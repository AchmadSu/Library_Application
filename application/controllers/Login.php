<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');
	
	/**
	 * 
	 */
	class Login extends CI_Controller {

		public function __construct()
		{
			parent::__construct();
			$this->load->model("M_library");
			$this->load->library('form_validation');
			$this->load->library('session');
			$this->load->library('user_agent');
		}

		// public function index()
		// {
		// 	// var_dump($this->session->userdata('mahasiswa'));exit();
		// 	if ($this->session->userdata('dosen') || $this->session->userdata('mahasiswa')) {
		// 		header('location: '.base_url()."index.php");	
		// 	}

		// 	elseif ($this->session->userdata('admin')) {
		// 		header('location: '.base_url()."index.php/adminPresence");	
		// 	}

		// 	$data['content'] = 'v_login';
		// 	// $data["rowUser"] = $this->M_user->getUserId($id);
		// 	$this->load->view('v_akademik', $data);
		// }

		public function checkLogin()
		{
			header("Access-Control-Allow-Origin: *");
		    header("Access-Control-Allow-Headers: access");
		    header("Access-Control-Allow-Methods: POST");
		    header("Access-Control-Allow-Credentials: true");
		    header('Content-Type: application/json');

			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			// $data['content'] = 'v_login';
			// $dataJson = json_decode(file_get_contents('php://input'), true);
			if($this->input->post('user_code') != NULL) {$user_code = $this->input->post('user_code');} else {$user_code = '';}
			if($this->input->post('user_password') != NUll) { $user_password = $this->input->post('user_password'); } else {$user_password = '';}

			$checkQuery = $this->M_library->checkLogin($user_code, md5($user_password));
			
			if ($checkQuery == TRUE) {
				echo json_encode($checkQuery);				
			}
			else
			{
				// $session_array = 0;
				echo json_encode($checkQuery);
			}
		}

		// public function getUser(){
		// 	$checkQuery = $this->M_library->getUser();
		// 	if ($checkQuery) {
		// 		foreach ($checkQuery->result as $rowUser) {
		// 			echo
		// 		}
		// 	}
		// }
	}