<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');error_reporting(E_ERROR | E_PARSE);
	class AdminPresence extends CI_Controller {
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
				$data['content'] = 'v_presenceAdmin';

				$data['count_jadwal'] = $this->M_akademik->getCountAllJadwal($data['jurusan_id']);
				$data['list_jadwal'] = $this->M_akademik->getAllJadwal($data['jurusan_id']);
				$data['list_todayJadwal'] = $this->M_akademik->getTodayJadwal($data['jurusan_id']);
				$data['list_allPresence'] = $this->M_akademik->getAllPresence($data['jurusan_id']);
				$data['list_countAllPresence'] = $this->M_akademik->getCountAllPresence($data['jurusan_id']);
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

		public function getSelected()
		{
			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');

			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$date_presence = strtotime($this->input->post('presence_date'));
				$new_format = date('Y-m-d', $date_presence);

				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_presenceSelected';
				// var_dump($new_format);exit();
				$data['count_jadwal'] = $this->M_akademik->getCountAllJadwal($data['jurusan_id']);
				$data['list_jadwal'] = $this->M_akademik->getAllJadwal($data['jurusan_id']);
				$data['list_allPresence'] = $this->M_akademik->getPresenceSelected($new_format);
				$data['tanggal_presensi'] = date("j M Y", $date_presence);
				$data['list_countAllPresence'] = $this->M_akademik->getCountAllPresence($data['jurusan_id']);
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

		public function detailPresence($jadwal_id){
			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');
			// var_dump(date('Y-m-d'));exit();
			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_presenceDetail';

				$data['get_jadwal'] = $this->M_akademik->getJadwalById($jadwal_id);
				$data['detail_presenceMhs'] = $this->M_akademik->getDetailPresence($jadwal_id, date("Y-m-d"), 'Mahasiswa');
				$data['detail_presenceDosen'] = $this->M_akademik->getDetailPresence($jadwal_id, date("Y-m-d"), 'Dosen');
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

		public function detailAllPresence($jadwal_id, $presence_date){
			date_default_timezone_set("Asia/Jakarta");
			setlocale(LC_ALL, 'IND');
			// var_dump(date('Y-m-d'));exit();
			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_presenceDetail';
				$data['get_jadwal'] = $this->M_akademik->getJadwalById($jadwal_id);
				// var_dump($get_jadwal);exit();
				$data['tanggal_presensi'] = date("j M Y", strtotime($presence_date));
				$data['detail_presenceMhs'] = $this->M_akademik->getDetailPresence($jadwal_id, date("Y-m-d", strtotime($presence_date)), 'Mahasiswa');
				$data['detail_presenceDosen'] = $this->M_akademik->getDetailPresence($jadwal_id, date("Y-m-d", strtotime($presence_date)), 'Dosen');
				// $data['detail_presence'] = $this->M_akademik->getDetailPresence($jadwal_id, date("Y-m-d", strtotime($presence_date)));
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