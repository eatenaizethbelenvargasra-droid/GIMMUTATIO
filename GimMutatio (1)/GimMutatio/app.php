<?php
declare(strict_types=1);
$config = require __DIR__ . '/config.php';
date_default_timezone_set($config['timezone']);
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_name('mutatio_session');
    session_set_cookie_params(['httponly' => true, 'samesite' => 'Lax', 'secure' => !empty($_SERVER['HTTPS'])]);
    session_start();
}

function db(): PDO
{
    static $pdo;
    global $config;
    if ($pdo instanceof PDO) return $pdo;
    $pdo = new PDO('mysql:host='.$config['db_host'].';dbname='.$config['db_name'].';charset=utf8mb4', $config['db_user'], $config['db_pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    seed_demo($pdo);
    return $pdo;
}

function seed_demo(PDO $pdo): void
{
    $count = (int)$pdo->query('SELECT COUNT(*) FROM users')->fetchColumn();
    if ($count === 0) {
        $stmt = $pdo->prepare('INSERT INTO users (name,email,password_hash,role) VALUES (?,?,?,?)');
        $stmt->execute(['Administrador Mutatio', 'admin@mutatio.local', password_hash('Mutatio2026!', PASSWORD_DEFAULT), 'admin']);
        $stmt->execute(['Recepción Mutatio', 'recepcion@mutatio.local', password_hash('Recepcion2026!', PASSWORD_DEFAULT), 'recepcionista']);
        $stmt->execute(['Cliente Demo Mutatio', 'cliente@mutatio.local', password_hash('Cliente2026!', PASSWORD_DEFAULT), 'cliente']);
        $clientId=$pdo->query("SELECT id FROM users WHERE email='cliente@mutatio.local'")->fetchColumn();
        $adminId=(int)$pdo->query("SELECT id FROM users WHERE email='admin@mutatio.local'")->fetchColumn();
        $pdo->prepare('INSERT INTO clients(user_id,name,email,phone,document_number) VALUES(?,?,?,?,?)')->execute([$clientId,'Cliente Demo','cliente@mutatio.local','70000001','DEMO-001']);
        $personId=(int)$pdo->lastInsertId();
        $planId=$pdo->query('SELECT id FROM plans WHERE active=1 ORDER BY duration_days LIMIT 1')->fetchColumn();
        if($planId){$end=(new DateTimeImmutable())->modify('+29 days')->format('Y-m-d');$pdo->prepare("INSERT INTO memberships(client_id,plan_id,start_date,end_date,status) VALUES(?,?,CURDATE(),?,'active')")->execute([$personId,$planId,$end]);$membershipId=(int)$pdo->lastInsertId();$price=$pdo->query('SELECT price FROM plans WHERE id='.(int)$planId)->fetchColumn();$pdo->prepare("INSERT INTO payments(client_id,membership_id,amount,payment_date,method,reference,recorded_by) VALUES(?,?,?,NOW(),'efectivo','Pago de bienvenida',?)")->execute([$personId,$membershipId,$price,$adminId]);}
    }
}

function h(?string $value): string { return htmlspecialchars((string)$value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); }
function money(float|int|string|null $amount): string { return 'Bs '.number_format((float)$amount, 2, ',', '.'); }
function current_user(): ?array { return $_SESSION['user'] ?? null; }
function user_avatar(?array $user=null): string {
    $user=$user??current_user();$name=(string)($user['name']??'?');$image=(string)($user['profile_image']??'');
    if($image!=='' && preg_match('~^uploads/profiles/[a-f0-9]{32}\.(jpg|png|webp)$~',$image)) return '<img class="avatar-image" src="'.h($image).'" alt="Foto de '.h($name).'">';
    return h(mb_substr($name,0,1));
}
function is_admin(): bool { return (current_user()['role'] ?? '') === 'admin'; }
function is_staff(): bool { return in_array(current_user()['role'] ?? '', ['admin','recepcionista'], true); }
function require_login(): void { if (!current_user()) { header('Location: index.php?view=login'); exit; } }
function require_admin(): void { require_login(); if (!is_admin()) { http_response_code(403); exit('Acceso reservado para administración.'); } }
function require_staff(): void { require_login(); if (!is_staff()) { http_response_code(403); exit('Acceso reservado para el personal del gimnasio.'); } }
function csrf_token(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function verify_csrf(): void { if (!hash_equals(csrf_token(), (string)($_POST['csrf'] ?? ''))) { http_response_code(419); exit('La sesión expiró. Recarga la página e inténtalo nuevamente.'); } }
function flash(string $message, string $type='success'): void { $_SESSION['flash'] = [$message,$type]; }
function redirect(string $view='dashboard'): never { header('Location: index.php?view='.rawurlencode($view)); exit; }
function log_action(string $action, string $entity, ?int $entityId=null): void {
    $u=current_user(); if (!$u) return;
    $s=db()->prepare('INSERT INTO audit_log(user_id,action,entity,entity_id,ip_address) VALUES (?,?,?,?,?)');
    $s->execute([$u['id'],$action,$entity,$entityId,$_SERVER['REMOTE_ADDR'] ?? null]);
}
function active_membership(int $clientId): ?array {
    $s=db()->prepare("SELECT m.*,p.name AS plan_name,p.price,p.duration_days FROM memberships m JOIN plans p ON p.id=m.plan_id WHERE m.client_id=? AND m.status='active' AND m.end_date>=CURDATE() ORDER BY m.end_date DESC LIMIT 1");
    $s->execute([$clientId]); return $s->fetch() ?: null;
}
function client_for_user(): ?array {
    $u=current_user(); if (!$u) return null;
    $s=db()->prepare('SELECT * FROM clients WHERE user_id=? LIMIT 1'); $s->execute([$u['id']]); return $s->fetch() ?: null;
}
