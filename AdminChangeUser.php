<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');error_reporting(E_ERROR | E_PARSE);
	class AdminChangeUser extends CI_Controller {
		// Construct ini dapat juga berfungsi untuk memanggil pertama helper atau library yang akan digunakan
		public function __construct()
		{
			parent::__construct();
			$this->load->model("M_akademik");
			$this->load->library('form_validation');
			$this->load->library(array('form_validation','session'));
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
				$data['content'] = 'v_adminChangeUser';

				// $data['count_jadwal'] = $this->M_akademik->getCountAllJadwal($data['jurusan_id']);
				// $data['list_jadwal'] = $this->M_akademik->getAllJadwal($data['jurusan_id']);
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

		public function admin()
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
				$data['content'] = 'v_allAdmin';

				$data['list_admin'] = $this->M_akademik->getAllAdmin();
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

		public function mahasiswa()
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
				$data['content'] = 'v_allMhs';

				$data['list_mhs'] = $this->M_akademik->getAllMhs($data['jurusan_id']);
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

		public function dosen()
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
				$data['content'] = 'v_allDosen';

				$data['list_dosen'] = $this->M_akademik->getAllDosen($data['jurusan_id']);
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

		public function insert($user_status)
		{
			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_insertUser';

				// $data['data_user'] = $this->M_akademik->getOneUser($code_id);
				// $data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_class'] = $this->M_akademik->getAllKelas($data['jurusan_id']);
				$data['data_jurusan'] = $this->M_akademik->getAllJurusan($data['jurusan_id']);
				// $data['list_jadwal'] = $this->M_akademik->getAllJadwal();
				// $data['status_presence'] = $this->M_akademik->checkPresenceStatus()
				$data['time'] =  date('H:i:s');
				$data['today'] =  date('l');
				$data['startDate'] = '06/06/2022';
				$data['status'] = $user_status;
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

			//$this->M_akademik->updateUser($user_id, $data);
			// $this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diedit!</h6>');
			// header("location: ".base_url()."index.php/AdminChangeUser/mahasiswa");
		}

		public function update($code_id)
		{
			if ($data['session'] = $this->session->userdata('admin')) 
			{
				$data['user_name'] = $data['session']['session_user_name'];
	        	$data['user_email'] = $data['session']['user_email'];
	        	$data['user_gender'] = $data['session']['user_gender'];
	        	// $data['class_id'] = $data['session']['class_id'];
	        	$data['jurusan_id'] = $data['session']['jurusan_id'];
	        	$data['user_nidn'] = $data['session']['session_user_nidn'];
	        	$data['user_id'] = $data['session']['session_user_id'];
				$data['content'] = 'v_updateUser';

				$data['data_user'] = $this->M_akademik->getOneUser($code_id);
				$data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_class'] = $this->M_akademik->getAllKelas($data['jurusan_id']);
				$data['data_jurusan'] = $this->M_akademik->getAllJurusan($data['jurusan_id']);
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

			//$this->M_akademik->updateUser($user_id, $data);
			// $this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diedit!</h6>');
			// header("location: ".base_url()."index.php/AdminChangeUser/mahasiswa");
		}

		public function addUser($status)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$this->form_validation->set_rules('user_name','user_name', 'required|min_length[3]|max_length[50]');
			// $this->form_validation->set_rules('last_name','last_name', 'required|min_length[3]|max_length[50]');
			$this->form_validation->set_rules('user_password','user_password','required|min_length[8]|max_length[200]');
			$this->form_validation->set_rules('password_validation', 'password_validation', 'matches[user_password]');

			//var_dump($this->form_validation->run() == TRUE);exit();
			if ($this->form_validation->run() == TRUE) 
			{
				$user_nim = ucwords($this->input->post('user_nim'));
				$user_nidn = ucwords($this->input->post('user_nidn'));
				$user_email = $this->input->post('user_email');

				if ($user_nim == NULL) {
					$user_code = $user_nidn;
				}
				if ($user_nidn == NULL) {
					$user_nidn = $user_nim;
				}

				$checkData = $this->M_akademik->checkInsertUser($user_code, $user_email);
				//var_dump($checkData);exit();
				if ($checkData == NULL) {
					$enc_password = md5($this->input->post('user_password'));
					$user_status = $this->input->post('user_status');
					$user_date = strtotime($this->input->post('user_date'));
					$new_format = date('Y-m-d 00-00-00', $user_date);
					$user_name = ucwords($this->input->post('user_name'));
					$user_address = ucwords($this->input->post('user_address'));
					$user_gender = $this->input->post('user_gender');
					$user_status = $status;
					
					if ($status == "Mahasiswa") {
						$class_id = $this->input->post('class_id');
						$jurusan = $this->M_akademik->getJurusanByClass($class_id);
						$jurusan_id = $jurusan->jurusan_id;
						// var_dump($jurusan);exit();
					}
					elseif ($status == "Dosen") {
						$jurusan_id = $this->input->post('jurusan_id');
						$class_id = 0;
					}

					$data = array(
						'user_name' => $user_name,
						'user_password' => $enc_password,
						'user_email' => $user_email,
						'user_nim' => $user_nim,
						'user_nidn' => $user_nidn,
						'user_address' => $user_address,
						'user_gender' => $user_gender,
						'user_date' => $new_format,
						'class_id' => $class_id,
						'user_status' => $user_status,
						'jurusan_id' => $jurusan_id,
						'user_active' => 'active'
					);

					$this->M_akademik->insertUser($data);
					$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil ditambahkan!</h6>');
					header("location: ".base_url()."index.php/AdminChangeUser/$status");
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspEmail dan/atau NIM/NIDN sudah terdaftar!</h6>');
					header("location: ".base_url()."index.php/AdminChangeUser/insert/$status");		
				}
			}
			else
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspUsername minimal 3 karakter dan maksimal 50 karakter dan/atau Password harus minimal 8 karakter dan/atau yang anda inputkan Tidak Cocok!</h6>');
				header("location: ".base_url()."index.php/AdminChangeUser/insert/$status");	
			}

		}

		public function save($user_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}

			$checkQuery = $this->M_akademik->checkUpdateUser($user_id, md5($this->input->post('user_password')));

			// var_dump($checkQuery);exit();

			if ($checkQuery == NULL) {
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspPassword yang anda inputkan Tidak Cocok!</h6>');
				header("location: ".base_url()."index.php/AdminChangeUser/update/$user_id");
			}
			else
			{
			
				$this->form_validation->set_rules('user_name','user_name', 'required|min_length[3]|max_length[50]');
				// $this->form_validation->set_rules('last_name','last_name', 'required|min_length[3]|max_length[50]');
				$this->form_validation->set_rules('user_password','user_password','required|min_length[8]|max_length[200]');

				$enc_password = md5($this->input->post('user_password'));
				
				if ($this->input->post('user_new_password') != NULL) {
					$this->form_validation->set_rules('user_new_password','user_new_password','required|min_length[8]|max_length[200]');
					$this->form_validation->set_rules('password_validation', 'password_validation', 'matches[user_new_password]');
					$enc_password = md5($this->input->post('user_new_password'));
				}

				if ($this->form_validation->run() == TRUE) {
					$user_id = $this->input->post('user_id');
					$user_email = $this->input->post('user_email');
					$user_nim = ucwords($this->input->post('user_nim'));
					$user_status = $this->input->post('user_status');
					$user_date = strtotime($this->input->post('user_date'));
					$new_format = date('Y-m-d 00-00-00', $user_date);
					if ($user_nim == NULL) {
						$user_nim = '';
					}
					$user_nidn = ucwords($this->input->post('user_nidn'));
					if ($user_nidn == NULL) {
						$user_nidn = '';
					}
					$user_name = ucwords($this->input->post('user_name'));
					$user_address = ucwords($this->input->post('user_address'));
					$user_gender = $this->input->post('user_gender');
					$class_id = $this->input->post('class_id');
					
					if ($class_id == NULL) {
						$class_id = 0;
					}

					$jurusan_id = $this->input->post('jurusan_id');
					if ($jurusan_id == NULL) {
						$jurusan = $this->M_akademik->getJurusanByClass($class_id);
						$jurusan_id = $jurusan->jurusan_id;
					}

					$data = array(
						'user_name' => $user_name,
						'user_password' => $enc_password,
						'user_email' => $user_email,
						'user_nim' => $user_nim,
						'user_nidn' => $user_nidn,
						'user_address' => $user_address,
						'user_gender' => $user_gender,
						'user_date' => $new_format,
						'class_id' => $class_id,
						'jurusan_id' => $jurusan_id,
						'user_active' => 'active'
					);

					$this->M_akademik->updateUser($user_id, $data);

					if ($user_status == 'Mahasiswa') {
						$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
						header("location: ".base_url()."index.php/AdminChangeUser/mahasiswa");	
					} else {
						$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
						header("location: ".base_url()."index.php/AdminChangeUser/dosen");
					}
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspUsername minimal 3 karakter dan maksimal 50 karakter dan atau Password yang anda inputkan Tidak Cocok!</h6>');
					header("location: ".base_url()."index.php/AdminChangeUser/update/$user_id");	
				}
			}

		}

		public function delete($user_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			$this->M_akademik->deleteUser($user_id);
			$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil dihapus!</h6>');
			header("location: ".base_url()."index.php/AdminChangeUser/mahasiswa");
		}

		public function deleteDosen($user_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$data = array(
				'user_active' => 'inactive'
			);

			$this->M_akademik->deleteDosen($user_id, $data);
			$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil dihapus!</h6>');
			header("location: ".base_url()."index.php/AdminChangeUser/dosen");
		}

	}
?>