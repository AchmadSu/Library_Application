<?php
    // required headers
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: access");
    header("Access-Control-Allow-Methods: POST");
    header("Access-Control-Allow-Credentials: true");
    header('Content-Type: application/json');
    // include database and object files
    include_once 'config.php';
    $data = json_decode(file_get_contents('php://input'), true);
    if (!isset($data['user_id']) && !isset($data['user_name']) && !isset($data['user_divisi']) && !isset($data['user_prodi']))
    {
        http_response_code(404);
        die(); // receiving the post params
    } else {
        $user_id = $data['user_id'];
        $user_name = $data['user_name'];
        $user_nim = $data['user_nim'];
        $user_prodi = $data['user_prodi'];
        $user_divisi = $data['user_divisi'];

        $query = "UPDATE t_user SET user_name = '$user_name', user_nim = '$user_nim', user_prodi = '$user_prodi', user_tahun = '$user_tahun', user_divisi = '$user_divisi' WHERE user_id = $user_id";
        // $result = mysqli_query($conn, $query);
        // print($query);
        if ($conn->query($query) === TRUE){
            $conn->close();
            $response['status'] = 0;
            $response['message'] = "Update berhasil";
            http_response_code(200);
            echo json_encode($response);
            return;
        }
        else {
            $conn->close();
            $response['status'] = 1;
            $response['message'] = "Update gagal";
            http_response_code(404);
            echo json_encode($response);
        }
    }
?>
