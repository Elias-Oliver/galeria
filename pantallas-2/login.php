<?php
// login.php
include '../conexion/conexion.php';
session_start();

// --- Lógica de login y definición de contraseña ---
$mensaje = '';
$isFirstTime = false;
$email = '';
if (isset($_GET['token'])) {
    // Buscar galería por token
    $token = mysqli_real_escape_string($conn, $_GET['token']);
    $sql = "SELECT * FROM galerias WHERE token = '$token' LIMIT 1";
    $res = mysqli_query($conn, $sql);
    if ($res && mysqli_num_rows($res) > 0) {
        $galeria = mysqli_fetch_assoc($res);
        $email = $galeria['client_email'];
        // Buscar usuario
        $sql_user = "SELECT * FROM usuarios WHERE email = '$email' LIMIT 1";
        $res_user = mysqli_query($conn, $sql_user);
        if ($res_user && mysqli_num_rows($res_user) > 0) {
            $usuario = mysqli_fetch_assoc($res_user);
            $isFirstTime = empty($usuario['password_hash']);
        } else {
            $isFirstTime = true;
        }
    } else {
        $mensaje = 'Enlace inválido o expirado.';
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];
    if (isset($_POST['confirm_password'])) {
        // Definir contraseña por primera vez
        $confirm = $_POST['confirm_password'];
        if ($password !== $confirm) {
            $mensaje = 'Las contraseñas no coinciden.';
        } elseif (strlen($password) < 6) {
            $mensaje = 'La contraseña debe tener al menos 6 caracteres.';
        } else {
            $hash = password_hash($password, PASSWORD_DEFAULT);
            // Crear o actualizar usuario
            $sql_user = "SELECT * FROM usuarios WHERE email = '$email' LIMIT 1";
            $res_user = mysqli_query($conn, $sql_user);
            if ($res_user && mysqli_num_rows($res_user) > 0) {
                mysqli_query($conn, "UPDATE usuarios SET password_hash = '$hash' WHERE email = '$email'");
            } else {
                mysqli_query($conn, "INSERT INTO usuarios (email, tipo, password_hash) VALUES ('$email', 'cliente', '$hash')");
            }
            $_SESSION['cliente_email'] = $email;
            header('Location: galeria_privada.php?token=' . $_GET['token']);
            exit;
        }
    } else {
        // Login normal
        $sql_user = "SELECT * FROM usuarios WHERE email = '$email' LIMIT 1";
        $res_user = mysqli_query($conn, $sql_user);
        if ($res_user && mysqli_num_rows($res_user) > 0) {
            $usuario = mysqli_fetch_assoc($res_user);
            if (password_verify($password, $usuario['password_hash'])) {
                $_SESSION['cliente_email'] = $email;
                header('Location: galeria_privada.php?token=' . $_GET['token']);
                exit;
            } else {
                $mensaje = 'Contraseña incorrecta.';
            }
        } else {
            $mensaje = 'Usuario no encontrado.';
        }
    }
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Cuenta - Galería Privada</title>
</head>
<body>
    <h2>Acceso a tu galería privada</h2>
    <?php if ($mensaje): ?>
        <div style="background:#ffeaea;color:#c00;padding:10px;border-radius:6px;margin-bottom:16px;"> <?php echo $mensaje; ?> </div>
    <?php endif; ?>
    <?php if (!isset($_GET['token']) || empty($email)): ?>
        <p>Enlace inválido o expirado.</p>
    <?php else: ?>
        <form method="POST">
            <label for="email">Correo electrónico:</label><br>
            <input type="email" name="email" value="<?php echo htmlspecialchars($email); ?>" readonly style="background:#eee;"><br>
            <label for="password"><?php echo $isFirstTime ? 'Nueva Contraseña' : 'Contraseña'; ?>:</label><br>
            <input type="password" name="password" required minlength="6"><br>
            <?php if ($isFirstTime): ?>
                <label for="confirm_password">Confirmar Contraseña:</label><br>
                <input type="password" name="confirm_password" required minlength="6"><br>
            <?php endif; ?>
            <button type="submit" style="margin-top:10px;"> <?php echo $isFirstTime ? 'Configurar Contraseña' : 'Iniciar Sesión'; ?> </button>
        </form>
    <?php endif; ?>
</body>
</html>
