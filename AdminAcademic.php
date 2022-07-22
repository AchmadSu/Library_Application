<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');error_reporting(E_ERROR | E_PARSE);
	class AdminAcademic extends CI_Controller {
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
				$data['content'] = 'v_adminAcademic';

				// $data['count_jadwal'] = $this->M_akademik->getCountAllJadwal($data['jurusan_id']);
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

		public function dataJadwal()
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
				$data['content'] = 'v_allJadwal';

				// $data['list_matkul'] = $this->M_akademik->getAllJadwal();
				$data['list_jadwal'] = $this->M_akademik->getAllDataJadwal($data['jurusan_id']);
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

		public function insertJadwal()
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
				$data['content'] = 'v_insertJadwal';

				$data['data_dosen'] = $this->M_akademik->getAllDosen($data['jurusan_id']);
				$data['data_class'] = $this->M_akademik->getAllKelas($data['jurusan_id']);
				// $data['data_kurikulum'] = $this->M_akademik->getAllKurikulum();
				$data['data_matakuliah'] = $this->M_akademik->getAllMatakuliah();
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

		public function updateJadwal($jadwal_id)
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
				$data['content'] = 'v_updateJadwal';

				$data['data_dosen'] = $this->M_akademik->getAllDosen($data['jurusan_id']);
				$data['data_class'] = $this->M_akademik->getAllKelas($data['jurusan_id']);
				// $data['data_kurikulum'] = $this->M_akademik->getAllKurikulum();
				$data['data_matakuliah'] = $this->M_akademik->getAllMatakuliah();
				$data['data_jadwal'] = $this->M_akademik->getDataJadwalById($jadwal_id);
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

		public function addJadwal()
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$class_id = $this->input->post('class_id');
			$matakuliah_id = $this->input->post('matakuliah_id');
			$user_id = $this->input->post('user_id');
			$jadwal_start_at = $this->input->post('jadwal_start_at');
			$jadwal_ended_at = $this->input->post('jadwal_ended_at');
			$days_post = $this->input->post('days_post');

			$timeStart = date("H:i", strtotime($jadwal_start_at));
			$timeEnd = date("H:i", strtotime($jadwal_ended_at));
			// $now = date("H:i");
			$timeStartObject = DateTime::createFromFormat('H:i', $timeStart);
			$timeEndObject = DateTime::createFromFormat('H:i', $timeEnd);
			// $timeNow = DateTime::createFromFormat('H:i', $now);
			// $timeAdd = DateTime::createFromFormat('H:i', $addTime);

			// var_dump($timeStartObject);exit();

			if ($timeStartObject >= $timeEndObject)
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspJam Mulai lebih besar dari Jam akhir! Mohon Perbaiki!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/insertJadwal/");
			}
			elseif ($timeStartObject < $timeEndObject) 
			{
				$arr_check = array(
					0 => $days_post,
					1 => $matakuliah_id,
					2 => $class_id,
					3 => $jadwal_start_at,
					4 => $jadwal_ended_at,
					5 => $user_id
				);
				// var_dump($arr_check[3]);exit();
				if ($arr_check[0] != NULL && $arr_check[1] != NULL && $arr_check[2] != NULL && $arr_check[3] != NULL && $arr_check[4] != NULL && $arr_check[5] != NULL) {
					$checkData = $this->M_akademik->checkInsertJadwal($arr_check);

					// $setTime = strtotime($rowJadwal->jadwal_start_at);
					if ($checkData == NULL) {
						$data = array(
							"jadwal_day" => $days_post,
							"matakuliah_id" => $matakuliah_id,
							"class_id" => $class_id,
							"jadwal_start_at" => date('H:i:s', strtotime($jadwal_start_at)),
							"jadwal_ended_at" => date('H:i:s', strtotime($jadwal_ended_at)),
							"user_id" => $user_id
						);
						$this->M_akademik->insertJadwal($data);
						$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil ditambahkan!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/dataJadwal");
					}
					else
					{
						$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspJadwal sudah terdaftar!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/insertJadwal");		
					}
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTerdapat data yang kosong! Isi semua dengan benar!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/insertJadwal/");	
				}
			}
		}

		public function saveJadwal($jadwal_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$jadwal_id = $this->input->post('jadwal_id');
			$class_id = $this->input->post('class_id');
			$matakuliah_id = $this->input->post('matakuliah_id');
			$user_id = $this->input->post('user_id');
			$jadwal_start_at = $this->input->post('jadwal_start_at');
			$jadwal_ended_at = $this->input->post('jadwal_ended_at');
			$days_post = $this->input->post('days_post');

			$timeStart = date("H:i", strtotime($jadwal_start_at));
			$timeEnd = date("H:i", strtotime($jadwal_ended_at));
			// $now = date("H:i");
			$timeStartObject = DateTime::createFromFormat('H:i', $timeStart);
			$timeEndObject = DateTime::createFromFormat('H:i', $timeEnd);

			if ($timeStartObject >= $timeEndObject)
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspJam Mulai lebih besar dari Jam akhir! Mohon Perbaiki!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/updateJadwal/$jadwal_id");
			}
			elseif($timeStartObject < $timeEndObject)
			{
				$arr_check = array(
					0 => $days_post,
					1 => $matakuliah_id,
					2 => $class_id,
					3 => $jadwal_start_at,
					4 => $jadwal_ended_at,
					5 => $user_id
				);
				// var_dump($arr_check[3]);exit();
				if ($arr_check[0] != NULL && $arr_check[1] != NULL && $arr_check[2] != NULL && $arr_check[3] != NULL && $arr_check[4] != NULL && $arr_check[5] != NULL) {
					$data = array(
						"jadwal_day" => $days_post,
						"matakuliah_id" => $matakuliah_id,
						"class_id" => $class_id,
						"jadwal_start_at" => date('H:i:s', strtotime($jadwal_start_at)),
						"jadwal_ended_at" => date('H:i:s', strtotime($jadwal_ended_at)),
						"user_id" => $user_id
					);
					$this->M_akademik->updateJadwal($jadwal_id, $data);
					$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/dataJadwal");
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTerdapat data yang kosong! Isi semua dengan benar!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateJadwal/$jadwal_id");	
				}
			}
		}

		public function dataMataKuliah()
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
				$data['content'] = 'v_allMatkul';

				$data['list_matkul'] = $this->M_akademik->getAllMataKuliah();
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

		public function insertMataKuliah()
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
				$data['content'] = 'v_insertMataKuliah';

				// $data['data_user'] = $this->M_akademik->getOneUser($code_id);
				// $data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_kurikulum'] = $this->M_akademik->getAllKurikulum();
				// $data['data_jurusan'] = $this->M_akademik->getAllJurusan();
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

		public function addMataKuliah()
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$this->form_validation->set_rules('matakuliah_name','matakuliah_name', 'required|min_length[3]|max_length[50]');

			if ($this->form_validation->run() == TRUE) {
				$matakuliah_name = ucwords($this->input->post('matakuliah_name'));
				$kurikulum_id = $this->input->post('kurikulum_id');
				$matakuliah_sks = $this->input->post('matakuliah_sks');
				$matakuliah_type = $this->input->post('matakuliah_type');

				$checkData = $this->M_akademik->checkInsertMatkul($matakuliah_name);
				//var_dump($checkData);exit();
				if ($checkData == NULL) {

					$allowed_types = array('gif','jpg','jpeg','png');
					$file_name = $_FILES["matakuliah_picture"]["name"];
					$file_tmp = $_FILES["matakuliah_picture"]["tmp_name"];
					$file_size = $_FILES["matakuliah_picture"]["size"];
					$explode = explode('.', $file_name);

					$extension = strtolower(end($explode));
					if ((in_array($extension, $allowed_types)) == TRUE ) {
						move_uploaded_file($file_tmp,'assets/img/course/'.$file_name);
						$data = array(
							'matakuliah_name' => $matakuliah_name,
							'kurikulum_id' => $kurikulum_id,
							'matakuliah_sks' => $matakuliah_sks,
							'matakuliah_type' => $matakuliah_type,
							'matakuliah_picture' => $file_name
						);

						$this->M_akademik->insertMataKuliah($data);
						$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil ditambahkan!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/dataMataKuliah");
						// $this->M_coffee->insertCoffee($data);
					}
					else
					{
						$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspEkstensi file tidak sesuai! Upload file dengan ekstensi gif, jpg, jpeg dan png!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/insertMataKuliah");		
					}
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspNama Mata Kuliah sudah terdaftar!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/insertMataKuliah");		
				}
			}
			else
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspNama Mata Kuliah minimal 3 karakter dan maksimal 50 karakter!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/insertMataKuliah/");	
			}

		}

		public function updateMataKuliah($matakuliah_id)
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
				$data['content'] = 'v_updateMataKuliah';

				// $data['data_user'] = $this->M_akademik->getOneUser($code_id);
				// $data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_matakuliah'] = $this->M_akademik->getMatkulById($matakuliah_id);
				$data['data_kurikulum'] = $this->M_akademik->getAllKurikulum();
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

		public function saveMataKuliah($matakuliah_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$this->form_validation->set_rules('matakuliah_name','matakuliah_name', 'required|min_length[3]|max_length[50]');

			if ($this->form_validation->run() == TRUE) {
				$matakuliah_id = $this->input->post('matakuliah_id');
				$matakuliah_name = ucwords($this->input->post('matakuliah_name'));
				$kurikulum_id = $this->input->post('kurikulum_id');
				$matakuliah_sks = $this->input->post('matakuliah_sks');
				$matakuliah_type = $this->input->post('matakuliah_type');

				// $checkData = $this->M_akademik->checkInsertMatkul($matakuliah_name);
				// var_dump($checkData);exit();
				
				if ($matakuliah_id == NULL) {
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTidak ada data terpilih!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateMataKuliah/$matakuliah_id");
				}
				elseif ($kurikulum_id == NULL) {
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTidak ada Kurikulum terpilih!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateMataKuliah/$matakuliah_id");
				}
					
				$allowed_types = array('gif','jpg','jpeg','png');
				$file_name = $_FILES["matakuliah_picture"]["name"];
				$file_tmp = $_FILES["matakuliah_picture"]["tmp_name"];
				$file_size = $_FILES["matakuliah_picture"]["size"];
				$explode = explode('.', $file_name);

				$extension = strtolower(end($explode));
				if ($file_name != NULL) {
					// var_dump((in_array($extension, $allowed_types)));exit();
					if ((in_array($extension, $allowed_types)) == TRUE ) {
						move_uploaded_file($file_tmp,'assets/img/course/'.$file_name);
						$data = array(
							'matakuliah_name' => $matakuliah_name,
							'kurikulum_id' => $kurikulum_id,
							'matakuliah_sks' => $matakuliah_sks,
							'matakuliah_type' => $matakuliah_type,
							'matakuliah_picture' => $file_name
						);
						$this->M_akademik->updateMataKuliah($matakuliah_id, $data);
						$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/dataMataKuliah");
					}
					else
					{
						$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspEkstensi file tidak sesuai! Upload file dengan ekstensi gif, jpg, jpeg dan png!</h6>');
						header("location: ".base_url()."index.php/AdminAcademic/updateMataKuliah/$matakuliah_id");		
					}
				}
				elseif ($file_name == NULL) {
					$data = array(
						'matakuliah_name' => $matakuliah_name,
						'kurikulum_id' => $kurikulum_id,
						'matakuliah_sks' => $matakuliah_sks,
						'matakuliah_type' => $matakuliah_type
					);
					$this->M_akademik->updateMataKuliah($matakuliah_id, $data);
					$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/dataMataKuliah");	
				}
			}
			else
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspUsername minimal 3 karakter dan maksimal 50 karakter!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/updateClass/$class_id");	
			}

		}

		public function dataClass()
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
				$data['content'] = 'v_allKelas';

				$data['list_kelas'] = $this->M_akademik->getAllKelas($data['jurusan_id']);
				$data['list_Mhs'] = $this->M_akademik->getAllMhs($data['jurusan_id']);
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

		public function dataMhsByClass($class_id)
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
				$data['content'] = 'v_getMhsByClass';

				$data['list_MhsByClass'] = $this->M_akademik->getMhsByClass($class_id);
				$data['data_class'] = $this->M_akademik->getClassById($class_id);
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

		public function insertClass()
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
				$data['content'] = 'v_insertClass';

				// $data['data_user'] = $this->M_akademik->getOneUser($code_id);
				// $data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_class'] = $this->M_akademik->getAllClass();
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
		}

		public function addClass()
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$this->form_validation->set_rules('class_name','class_name', 'required|min_length[3]|max_length[50]');

			if ($this->form_validation->run() == TRUE) {
				$class_name = ucwords($this->input->post('class_name'));
				$jurusan_id = $this->input->post('jurusan_id');

				$checkData = $this->M_akademik->checkInsertClass($class_name);
				//var_dump($checkData);exit();
				if ($checkData == NULL) {

					$data = array(
						'class_name' => $class_name,
						'jurusan_id' => $jurusan_id
					);

					$this->M_akademik->insertClass($data);
					$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil ditambahkan!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/dataClass");
				}
				else
				{
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspNama kelas sudah terdaftar!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/insertClass");		
				}
			}
			else
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspNama Kelas minimal 3 karakter dan maksimal 50 karakter!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/insertClass/$user_id");	
			}

		}

		public function updateClass($class_id)
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
				$data['content'] = 'v_updateKelas';

				// $data['data_user'] = $this->M_akademik->getOneUser($code_id);
				// $data['data_dosen'] = $this->M_akademik->getOneDosen($code_id);
				$data['data_class'] = $this->M_akademik->getClassById($class_id);
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

		}

		public function save($class_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			
			$this->form_validation->set_rules('class_name','class_name', 'required|min_length[3]|max_length[50]');

			if ($this->form_validation->run() == TRUE) {
				$class_id = $this->input->post('class_id');
				$class_name = $this->input->post('class_name');
				$jurusan_id = $this->input->post('jurusan_id');

				$checkData = $this->M_akademik->checkInsertClass($class_name);
				// var_dump($checkData);exit();
				
				if ($class_id == NULL) {
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTidak ada data terpilih!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateClass/$class_id");
				}
				elseif ($jurusan_id == NULL) {
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspTidak ada program studi terpilih!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateClass/$class_id");
				}
				

				elseif ($checkData != NULL) {
					$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspNama Kelas sudah ada! Mohon ubah dengan nama yang lain!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/updateClass/$class_id");
				}

				elseif ($checkData == NULL) {
					$data = array(
						'class_name' => $class_name,
						'jurusan_id' => $jurusan_id
					);

					$this->M_akademik->updateClass($class_id, $data);
					$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil diubah!</h6>');
					header("location: ".base_url()."index.php/AdminAcademic/dataClass");
				}	
			}
			else
			{
				$this->session->set_flashdata('warning', '<h6><i class="fa fa-exclamation-triangle sign"></i>&nbsp&nbspUsername minimal 3 karakter dan maksimal 50 karakter!</h6>');
				header("location: ".base_url()."index.php/AdminAcademic/updateClass/$class_id");	
			}

		}

		public function deleteKelas($class_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			$this->M_akademik->deleteKelas($class_id);
			$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil dihapus!</h6>');
			header("location: ".base_url()."index.php/AdminAcademic/dataClass");
		}

		public function deleteMataKuliah($matakuliah_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			$this->M_akademik->deleteMataKuliah($matakuliah_id);
			$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil dihapus!</h6>');
			header("location: ".base_url()."index.php/AdminAcademic/dataMataKuliah");
		}

		public function deleteJadwal($jadwal_id)
		{
			if ($this->session->userdata('admin') == NULL) {
				header("location: ".base_url()."index.php/login");
			}
			elseif ($this->session->userdata('mahasiswa') || $this->session->userdata('dosen'))
			{
				header("location: ".base_url()."index.php/presence");
			}
			$this->M_akademik->deleteJadwal($jadwal_id);
			$this->session->set_flashdata('success', '<h6><i class="fa fa-check-square-o sign"></i>&nbsp&nbspData berhasil dihapus!</h6>');
			header("location: ".base_url()."index.php/AdminAcademic/dataJadwal");
		}

	}
?>