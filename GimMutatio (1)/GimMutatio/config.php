<?php
declare(strict_types=1);

// Local XAMPP settings. Override with environment variables when needed.
return [
    'db_host' => getenv('MUTATIO_DB_HOST') ?: '127.0.0.1',
    'db_name' => getenv('MUTATIO_DB_NAME') ?: 'mutatiogym',
    'db_user' => getenv('MUTATIO_DB_USER') ?: 'root',
    'db_pass' => getenv('MUTATIO_DB_PASS') ?: '',
    'timezone' => 'America/La_Paz',
    'base_url' => getenv('MUTATIO_BASE_URL') ?: 'http://localhost/Gimnasio-Mutatio',
    'mail_from' => getenv('MUTATIO_MAIL_FROM') ?: 'no-reply@mutatio.local',
];
