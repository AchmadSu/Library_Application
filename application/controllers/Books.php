<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');
	
	/**
	 * 
	 */
	class Books extends CI_Controller {

		public function __construct()
		{
			parent::__construct();
			$this->load->model("M_library");
			$this->load->library('form_validation');
			$this->load->library('session');
			$this->load->library('user_agent');
		}

		public function getAllBooks()
		{
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: GET");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			$getQuery = $this->M_library->getAllBooks();
			// $i = 0;
			// foreach($getQuery->result() as $rowBook) {
			// 	$arrayImgBook[$i] = $rowBook->book_image;
			// 	// $separator = ",";
			// 	echo json_encode($arrayImgBook[$i].",");
			// 	$i++;
			// }
			echo json_encode($getQuery->result());
		}

		public function getBooksByCategory($book_category)
		{
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: GET");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			$getQuery = $this->M_library->getBooksByCategory($book_category);
			// $i = 0;
			// foreach($getQuery->result() as $rowBook) {
			// 	$arrayImgBook[$i] = $rowBook->book_image;
			// 	// $separator = ",";
			// 	echo json_encode($arrayImgBook[$i].",");
			// 	$i++;
			// }
			echo json_encode($getQuery->result());
		}

		public function getBookById($book_id)
		{
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: GET");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			$getQuery = $this->M_library->getBookById($book_id);

			echo json_encode($getQuery);
		}
		
		public function countAllBooks()
		{
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: GET");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			$getQuery = $this->M_library->getAllBooks();
			echo json_encode(count($getQuery->result()));
		}

		public function checkDataBook(){
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: post");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

		    $dataJson = json_decode(file_get_contents('php://input'), true);

		    $book_title = $dataJson['book_title'];
		    $book_author = $dataJson['book_author'];
		    $book_year = $dataJson['book_year'];
		    $book_publisher = $dataJson['book_publisher'];
		    $book_image = $dataJson['book_image'];
		    $book_category = $dataJson['book_category'];

		    $data = array(
		    	'book_title' => $book_title,
		    	'book_author' => $book_author,
		    	'book_year' => $book_year,
		    	'book_publisher' => $book_publisher,
		    	'book_image' => $book_image,
		    	'book_category' => $book_category,
		    );

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');
			$getQuery = $this->M_library->getDataBook($data);
			echo json_encode($getQuery);
		}

		public function insertBook(){
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: post");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

		    $dataJson = json_decode(file_get_contents('php://input'), true);

		    $book_title = $dataJson['book_title'];
		    $book_author = $dataJson['book_author'];
		    $book_year = $dataJson['book_year'];
		    $book_publisher = $dataJson['book_publisher'];
		    $book_image = $dataJson['book_image'];
		    $book_category = $dataJson['book_category'];

		    $data = array(
		    	'book_title' => $book_title,
		    	'book_author' => $book_author,
		    	'book_year' => $book_year,
		    	'book_publisher' => $book_publisher,
		    	'book_image' => $book_image,
		    	'book_category' => $book_category,
		    );

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');
			$addQuery = $this->M_library->insertBook($data);
		}

		public function updateBook($book_id){
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: post");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

		    $dataJson = json_decode(file_get_contents('php://input'), true);

		    $book_title = $dataJson['book_title'];
		    $book_author = $dataJson['book_author'];
		    $book_year = $dataJson['book_year'];
		    $book_publisher = $dataJson['book_publisher'];
		    $book_image = $dataJson['book_image'];
		    $book_category = $dataJson['book_category'];

		    $data = array(
		    	'book_title' => $book_title,
		    	'book_author' => $book_author,
		    	'book_year' => $book_year,
		    	'book_publisher' => $book_publisher,
		    	'book_image' => $book_image,
		    	'book_category' => $book_category,
		    );

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');
			$addQuery = $this->M_library->updateBook($book_id, $data);
		}

		public function delete($book_id){
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: post");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

	    	if (!isset($book_id)) {
	    		http_response_code(404);
	    		die();
	    	}
	    	else
	    	{
	    		$addQuery = $this->M_library->deleteBook($book_id);
	    	}
		}
	}
?>