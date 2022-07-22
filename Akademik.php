<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');

	class Akademik extends CI_Controller {
		// Construct ini dapat juga berfungsi untuk memanggil pertama helper atau library yang akan digunakan
		public function __construct()
		{
			parent::__construct();
			// $this->load->model("M_warunKoffee");
			$this->load->library('form_validation');
			$this->load->library('session');
		}

		public function index()
		{
			// load view v_beranda
			// $data['content'] = 'v_homeWK';
			// $data['list_owner'] = $this->M_warunKoffee->getAdmin();
			// $data['list_career'] = $this->M_warunKoffee->getCareer();
			// $data['history'] = $this->M_warunKoffee->getHistory();
			// var_dump($data['session']);exit();
			if ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen')) {
				if ($this->session->userdata('mahasiswa')) {
					$data['user_name'] = $_SESSION['mahasiswa']['session_user_name'];
		        	$data['user_email'] = $_SESSION['mahasiswa']['user_email'];
		        	$data['user_gender'] = $_SESSION['mahasiswa']['user_gender'];
		        	$data['class_id'] = $_SESSION['mahasiswa']['class_id'];
		        	$data['jurusan_id'] = $_SESSION['mahasiswa']['jurusan_id'];
		        	$data['user_nim'] = $_SESSION['mahasiswa']['session_user_nim'];	

		        	$data['content'] = 'v_Home';
	        		$this->load->view('v_akademik', $data);
				}
				else
				{
					$data['user_name'] = $_SESSION['dosen']['session_user_name'];
		        	$data['user_email'] = $_SESSION['dosen']['user_email'];
		        	$data['user_gender'] = $_SESSION['dosen']['user_gender'];
		        	$data['jurusan_id'] = $_SESSION['dosen']['jurusan_id'];
		        	$data['user_nidn'] = $_SESSION['dosen']['session_user_nidn'];
		        	$data['user_id'] = $_SESSION['dosen']['session_user_id'];

		        	$data['content'] = 'v_Home';
		        	// var_dump($data);exit();
	        		$this->load->view('v_akademik', $data);
				}
			}
			elseif ($this->session->userdata('admin')) 
			{
				redirect('Admin');
			}
			else
			{
				redirect('login');
			}
		}

		public function about()
		{
			// load view v_beranda
			// $data['content'] = 'v_homeWK';
			// $data['list_owner'] = $this->M_warunKoffee->getAdmin();
			// $data['list_career'] = $this->M_warunKoffee->getCareer();
			// $data['history'] = $this->M_warunKoffee->getHistory();
			// var_dump($data['session']);exit();
			if ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen')) {
				if ($this->session->userdata('mahasiswa')) {
					$data['user_name'] = $_SESSION['mahasiswa']['session_user_name'];
		        	$data['user_email'] = $_SESSION['mahasiswa']['user_email'];
		        	$data['user_gender'] = $_SESSION['mahasiswa']['user_gender'];
		        	$data['class_id'] = $_SESSION['mahasiswa']['class_id'];
		        	$data['jurusan_id'] = $_SESSION['mahasiswa']['jurusan_id'];
		        	$data['user_nim'] = $_SESSION['mahasiswa']['session_user_nim'];	

		        	$data['content'] = 'v_about';
	        		$this->load->view('v_akademik', $data);
				}
				else
				{
					$data['user_name'] = $_SESSION['dosen']['session_user_name'];
		        	$data['user_email'] = $_SESSION['dosen']['user_email'];
		        	$data['user_gender'] = $_SESSION['dosen']['user_gender'];
		        	$data['jurusan_id'] = $_SESSION['dosen']['jurusan_id'];
		        	$data['user_nidn'] = $_SESSION['dosen']['session_user_nidn'];
		        	$data['user_id'] = $_SESSION['dosen']['session_user_id'];

		        	$data['content'] = 'v_about';
		        	// var_dump($data);exit();
	        		$this->load->view('v_akademik', $data);
				}
			}
			elseif ($this->session->userdata('admin')) 
			{
				redirect('Admin');
			}
			else
			{
				redirect('login');
			}
		}

		public function academic()
		{
			// load view v_beranda
			// $data['content'] = 'v_homeWK';
			// $data['list_owner'] = $this->M_warunKoffee->getAdmin();
			// $data['list_career'] = $this->M_warunKoffee->getCareer();
			// $data['history'] = $this->M_warunKoffee->getHistory();
			// var_dump($data['session']);exit();
			if ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen')) {
				if ($this->session->userdata('mahasiswa')) {
					$data['user_name'] = $_SESSION['mahasiswa']['session_user_name'];
		        	$data['user_email'] = $_SESSION['mahasiswa']['user_email'];
		        	$data['user_gender'] = $_SESSION['mahasiswa']['user_gender'];
		        	$data['class_id'] = $_SESSION['mahasiswa']['class_id'];
		        	$data['jurusan_id'] = $_SESSION['mahasiswa']['jurusan_id'];
		        	$data['user_nim'] = $_SESSION['mahasiswa']['session_user_nim'];	

		        	$data['content'] = 'v_academic';
	        		$this->load->view('v_akademik', $data);
				}
				else
				{
					$data['user_name'] = $_SESSION['dosen']['session_user_name'];
		        	$data['user_email'] = $_SESSION['dosen']['user_email'];
		        	$data['user_gender'] = $_SESSION['dosen']['user_gender'];
		        	$data['jurusan_id'] = $_SESSION['dosen']['jurusan_id'];
		        	$data['user_nidn'] = $_SESSION['dosen']['session_user_nidn'];
		        	$data['user_id'] = $_SESSION['dosen']['session_user_id'];

		        	$data['content'] = 'v_academic';
		        	// var_dump($data);exit();
	        		$this->load->view('v_akademik', $data);
				}
			}
			elseif ($this->session->userdata('admin')) 
			{
				redirect('Admin');
			}
			else
			{
				redirect('login');
			}
		}
	}

 ?>