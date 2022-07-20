<?php defined('BASEPATH') OR exit('No direct script access allowed'); 
	class M_library extends CI_Model
	{
		private $user_table = "user_table";
		private $book_table = "book";

		public function checkLogin($user_code, $user_password){
			$this->db->select('*');
			$this->db->from($this->user_table);
			$this->db->where('user_name', $user_code);
			// $this->db->or_where('user_nidn', $user_code);
			$this->db->or_where('user_email', $user_code);
			$this->db->where('user_password', $user_password);
			$query = $this->db->get();

			return $query->row();
		}

		public function getUser($user_id){
			$this->db->select('*');
			$this->db->from($this->user_table);
			$this->db->where('user_id', $user_id);
			
			$query = $this->db->get();
			return $query->row();
		}

		public function getDataBook($data){
			$this->db->select('*');
			$this->db->from($this->book_table);
			$this->db->where('book_title', $data['book_title']);
			$this->db->where('book_author', $data['book_author']);
			$this->db->where('book_year', $data['book_year']);
			$this->db->where('book_publisher', $data['book_publisher']);
			$this->db->where('book_image', $data['book_image']);
			// $this->db->where('book_category', $data['book_category']);
			$query = $this->db->get();
			return $hasil = $query->row();
		}

		public function getAllBooks(){
			$this->db->select('*');
			$this->db->from($this->book_table);
			
			$query = $this->db->get();
			return $query;
		}

		public function getBooksByCategory($book_category){
			$this->db->select('*');
			$this->db->from($this->book_table);
			$this->db->where('book_category', $book_category);
			$query = $this->db->get();
			return $query;
		}

		public function getBookById($book_id){
			$this->db->select('*');
			$this->db->from($this->book_table);
			$this->db->where('book_id', $book_id);
			$query = $this->db->get();
			return $hasil = $query->row();
		}

		public function insertBook($data = array())
		{
			return $this->db->insert($this->book_table, $data);
		}

		public function updateBook($book_id, $data = array())
		{
			return $this->db->update($this->book_table, $data, array('book_id' => $book_id));
		}

		public function deleteBook($book_id)
		{
			return $this->db->delete($this->book_table, array("book_id" => $book_id));
		}
	}	

?>