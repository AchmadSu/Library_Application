<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');error_reporting(E_ERROR | E_PARSE);
	class Admin extends CI_Controller {
		// Construct ini dapat juga berfungsi untuk memanggil pertama helper atau library yang akan digunakan
		public function __construct()
		{
			parent::__construct();
			$this->load->model("M_akademik");
			$this->load->library('form_validation');
			$this->load->library('session');
		}

		public function index()
		{
			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_adminHome';

				// $data['count_jadwal'] = $this->M_akademik->getCountAllJadwal();
				// $data['list_jadwal'] = $this->M_akademik->getAllJadwal();
				// $data['status_presence'] = $this->M_akademik->checkPresenceStatus()
				$data['time'] =  date('H:i:s');
				$data['today'] =  date('l');
				$data['startDate'] = '06/06/2022';
				$this->load->view('v_admin', $data);

			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			else
			{
				header("location: ".base_url()."index.php/login");	
			}
		}

	}
?>