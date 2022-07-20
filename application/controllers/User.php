<?php if (!defined('BASEPATH')) exit ('No direct script access allowed');
	
	/**
	 * 
	 */
	class User extends CI_Controller {

		public function __construct()
		{
			parent::__construct();
			$this->load->model("M_library");
			$this->load->library('form_validation');
			$this->load->library('session');
			$this->load->library('user_agent');
		}

		public function getUser($user_id){
			$checkQuery = $this->M_library->getUser($user_id);

			if ($checkQuery) {
				echo json_encode($checkQuery);
			}
			else
			{
				$checkQuery = 0;
				echo json_encode($checkQuery);
			}
		}
	}