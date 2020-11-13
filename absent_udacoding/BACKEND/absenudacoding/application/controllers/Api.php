<?php
defined('BASEPATH') or exit('No Script Direct');
class Api extends CI_Controller
{
      function __construct()
      {
            parent::__construct();
            date_default_timezone_set('Asia/Jakarta');
            error_reporting(E_ALL);
            ini_set('Display Error', 1);
            header('Content-Type: Application/json');
      }

      function checkOut()
      {
            $update = array(
                  'id_absent' => $this->input->post('id_absent'),
                  'check_out' => date('Y-m-d H:i:s'),
                  'check_out_by' => $this->input->post('check_out_by'),
                  'id_user' => $this->input->post('iduser'),
                  'jam_kerja' => $this->input->post('jam_kerja'),
                  // 'phone_user' => $this->input->post('phone')
            );

            $this->db->where('id_absent', $update['id_absent']);
            $this->db->update('tb_absent', $update);

            if ($this->db->affected_rows() > 0) {
                  // berhasil update
                  $data = array(
                        'message' => 'Successfully Update ' . $this->db->affected_rows() . ' User',
                        'status' => 200,
                        'checkout' => $update,
                  );
            } else {
                  // tidak ada yang diupdate
                  $data = array(
                        'message' => 'Failed Update User',
                        'status' => 200,
                        'checkout' => $update,
                  );
            }
            echo json_encode($data);
      }

      function checkIn()
      {
            //check apakah sudah cek in ?
            $idUser = $this->input->post('iduser');
            $date_now = date('Y-m-d');

            $sqlCheck = "SELECT * FROM tb_absent WHERE id_user = $idUser AND date_today = '$date_now'";
            $queryCheck = $this->db->query($sqlCheck);
            if ($queryCheck->num_rows() > 0) {
                  foreach ($queryCheck->result() as $row) {
                        $this->db->set('check_in', date('Y-m-d H:i:s'));
                        $this->db->set('check_out', NULL);

                        $this->db->set('date_today', date('Y-m-d'));
                        $this->db->set('place', $this->input->post('place'));
                        $this->db->set('check_in_by', $this->input->post('check_in_by'));
                        $this->db->set('check_out_by', NULL);
                        $this->db->set('id_user', $this->input->post('iduser'));
                        $this->db->set('lang_loc',  $this->input->post('lang_loc'));
                        $this->db->set('long_loc', $this->input->post('long_loc'));

                        $this->db->where('id_absent', $row->id_absent);
                        $this->db->update('tb_absent');
                  }
                  if ($this->db->affected_rows() > 0) {
                        // berhasil update
                        $data = array(
                              'message' => 'Successfully Insert ' . $this->db->affected_rows() . ' Absent',
                              'status' => 200
                        );
                  } else {
                        // tidak ada yang diupdate
                        $data = array(
                              'message' => 'Failed Insert Absent',
                              'status' => 200
                        );
                  }
            } else {

                  $insert = array(
                        'check_in' => date('Y-m-d H:i:s'),
                        'date_today' => date('Y-m-d'),
                        'place' => $this->input->post('place'),
                        'check_in_by' => $this->input->post('check_in_by'),
                        'id_user' => $this->input->post('iduser'),
                        'lang_loc' => $this->input->post('lang_loc'),
                        'long_loc' => $this->input->post('long_loc'),
                  );

                  $this->db->insert('tb_absent', $insert);

                  if ($this->db->affected_rows() > 0) {
                        // berhasil update
                        $data = array(
                              'message' => 'Successfully Insert ' . $this->db->affected_rows() . ' Absent',
                              'status' => 200,
                              'checkin' => $insert,
                        );
                  } else {
                        // tidak ada yang diupdate
                        $data = array(
                              'message' => 'Failed Insert Absent',
                              'status' => 200,
                              'checkin' => $insert,
                        );
                  }
            }


            echo json_encode($data);
      }

      function registerUser()
      {
            $namefull = $this->input->post('name');
            $username = $this->input->post('username');
            $phone = $this->input->post('phone');
            $email = $this->input->post('email');
            $password = $this->input->post('password');
            $role = $this->input->post('role');

            $this->db->where('email_user', $email);
            $this->db->or_where('username_user', $username);
            $q = $this->db->get('tb_user');

            if ($q->num_rows() > 0) {
                  $data['status'] = 404;
                  $data['message'] = "Email atau Username telah terdaftar";
            } else {
                  $save['fullname_user'] = $namefull;
                  $save['id_role'] = $role;
                  $save['username_user'] = $username;
                  $save['phone_user'] = $phone;
                  $save['photo_user'] = "sample.png";
                  $save['email_user'] = $email;
                  $save['password_user'] = md5($password);

                  $querySaved = $this->db->insert('tb_user', $save);
                  if ($querySaved) {
                        $data['status'] = 200;
                        $data['message'] = 'Successfully Register';
                  } else {
                        $data['status'] = 404;
                        $data['message'] = 'Failed Register';
                  }
            }
            echo json_encode($data);
      }

      function loginUser()
      {
            $username = $this->input->post('username');
            $password = $this->input->post('password');

            $this->db->where('username_user', $username);
            $this->db->where('password_user', md5($password));

            $this->db->join("tb_role", "tb_user.id_role = tb_role.id_role");

            $this->db->select("
            tb_user.id_user,
            tb_user.fullname_user,
            tb_user.email_user,
            tb_user.phone_user,
            tb_user.photo_user,
            tb_user.username_user,

            tb_role.id_role,
            tb_role.name_role
            ");

            $q = $this->db->get('tb_user');

            if ($q->num_rows() > 0) {
                  $data['status'] = 200;
                  $data['message'] = 'Successfully Login User';
                  $data['user'] = $q->result();
            } else {
                  $data['status'] = 404;
                  $data['message'] = 'Failed Login User';
            }
            echo json_encode($data);
      }

      function getAbsent()
      {
            $idUser = $this->input->post('iduser');
            $date_now = date('Y-m-d');
            //   $date = new DateTime('2020-07-27');
            //   $date_now = $date->format('Y-m-d');
            $hasIdUser = $idUser != null || $idUser != "";

            $sql = "
            SELECT A.*, tb_absent.id_absent, tb_absent.check_in, tb_absent.check_out, tb_absent.place, tb_absent.lang_loc, tb_absent.long_loc
            FROM (
            SELECT tb_user.*, tb_role.name_role FROM tb_user
            LEFT JOIN tb_role ON tb_user.id_role = tb_role.id_role " . ((!$hasIdUser) ? "" : "WHERE tb_user.id_user = ?") . "
            ) as A
            LEFT JOIN tb_absent ON A.id_user = tb_absent.id_user AND tb_absent.date_today = '$date_now'
            ";

            // die($sql);
            //  $this->db->select("A.*, tb_absent.check_in, tb_absent.check_out");
            //  $this->db->from("tb_user");
            //  $this->db->join("tb_role", "tb_user.id_role = tb_role.id_role");
            //  $this->db->join("tb_absent", "tb_user.id_user = tb_absent.id_user AND tb_absent.date_today = $date_now");
            //  die($sql);
            //$query = $this->db->get('tb_user');

            if ($idUser != null || $idUser != "") {

                  //  $this->db->where('id_user', $idUser);
                  //  $query = $this->db->get();

                  $query = $this->db->query($sql, array($idUser));
                  if ($query->num_rows() > 0) {
                        $data['message'] = "Successfully Get Data Absent With Id";
                        $data['status'] = 200;
                        $data['absent'] = $query->result();
                  } else {
                        $data['message'] = "Failed Get Data News";
                        $data['status'] = 400;
                  }
            } else {
                  // echo $sql;
                  $q = $this->db->query($sql);
                  // $q = $this->db->get();
                  if ($q->num_rows() > 0) {
                        $data['message'] = "Successfully Get Data Absent Without Id";
                        $data['status'] = 200;
                        $data['absent'] = $q->result();
                  } else {
                        $data['message'] = "Failed Get Data Absent";
                        $data['status'] = 400;
                  }
            }

            // if ($data['user'] != null) {
            //     array_map($data['user'], function($user) {

            //     });
            // }

            echo json_encode($data);
      }

      function getHistoryById()
      {
            $idUser = $this->input->post('iduser');
            if ($idUser != null || $idUser != "") {
                  $this->db->where('id_user', $idUser);
                  $q = $this->db->get('tb_absent');
                  if ($q->num_rows() > 0) {
                        $data['idUser'] = $idUser;
                        $data['message'] = "Successfully Get History With Id";
                        $data['status'] = 200;
                        $data['dataHistory'] = $q->result();
                  } else {
                        $data['message'] = "Failed Get History Absent1";
                        $data['status'] = 400;
                  }
            } else {
                  $q = $this->db->get('tb_absent');
                  if ($q->num_rows() > 0) {
                        $data['idUser'] = $idUser;
                        $data['message'] = "Successfully Get History Without Id";
                        $data['status'] = 200;
                        $data['dataHistory'] = $q->result();
                  } else {
                        $data['message'] = "Failed Get History Absent2";
                        $data['status'] = 400;
                  }
            }

            echo json_encode($data);
      }

      function updateImage()
      {
            $idUser = $this->input->post('iduser');
            $config['upload_path'] = './image/';
            $config['allowed_types'] = 'gif|jpg|png|jpeg';

            $this->db->where('id_user', $idUser);
            $this->load->library('upload', $config);


            if (!$this->upload->do_upload('image')) {
                  $error = array('error' => $this->upload->display_errors());
                  $data1 = array(
                        'message' => $error,
                        'status' => 404,
                  );
            } else {
                  //upload to folder
                  $data = array('upload_data' => $this->upload->data());

                  //upload to database 
                  $save['photo_user'] = $data['upload_data']['file_name'];
                  $query = $this->db->update('tb_user', $save);

                  //output request
                  $data1 = array(
                        'message' => 'Successfully Update Absent',
                        'status' => 200,
                        'data' => $data['upload_data']['file_name'],
                  );
            }
            echo json_encode($data1);
      }

      function getRole()
      {
            /*$idUser = $this->input->post('iduser');
			//$this->db->where('id_user', $idUser);*/

            //$query = $this->db->get('tb_events');

            $q = $this->db->get('tb_role');
            if ($q->num_rows() > 0) {
                  $data['message'] = "Successfully Get Data News Without Id";
                  $data['status'] = 200;
                  $data['dataRole'] = $q->result();
            } else {
                  $data['message'] = "Failed Get Data News";
                  $data['status'] = 400;
            }

            echo json_encode($data);
      }

      function updateProfile()
      {

            $idUser = $this->input->post('iduser');
            $username = $this->input->post('username');
            $role = $this->input->post('id_role');
            $email = $this->input->post('email');
            $phone = $this->input->post('phone');

            $this->db->set('id_user', $idUser);

            if (!empty($username)) {
                  $this->db->set('username_user', $username);
            }
            if (!empty($role)) {
                  $this->db->set('id_role', $role);
            }
            if (!empty($email)) {
                  $this->db->set('email_user', $email);
            }
            if (!empty($phone)) {
                  $this->db->set('phone_user', $phone);
            }

            $update = array(
                  'id_user' => $idUser,
                  'username_user' => $username,
                  'id_role' => $role,
                  'email_user' => $email,
                  'phone_user' => $phone
            );

            $this->db->where('id_user', $idUser);
            $this->db->update('tb_user');

            if ($this->db->affected_rows() > 0) {
                  // berhasil update
                  $data = array(
                        'message' => 'Successfully Update ' . $this->db->affected_rows() . ' User',
                        'status' => 200,
                        'data' => $update,
                  );
            } else {
                  // tidak ada yang diupdate
                  $data = array(
                        'message' => 'Failed Update User',
                        'status' => 400,
                        'data' => $update
                  );
            }

            echo json_encode($data);
            die();

            $this->db->select("*");
            $this->db->from("tb_role");
            $this->db->join("tb_user", "tb_user.id_role = tb_role.id_role");
            $this->db->where('id_user', $idUser);

            if ($username == null || $username == "") {
                  $update['name_role'] = $role;
                  $update['email_user'] = $email;
                  $update['phone_user'] = $phone;
                  $query = $this->db->update('tb_user', $update);
                  if ($query) {
                        $data['message'] = 'Successfully Without Name';
                        $status['status'] = 200;
                  } else {
                        $data['message'] = 'Failed Without Name';
                        $status['status'] = 404;
                  }
            } else if ($role == null || $role == "") {
                  $update['username_user'] = $username;
                  $update['email_user'] = $email;
                  $update['phone_user'] = $phone;
                  $query = $this->db->update('tb_user', $update);
                  if ($query) {
                        $data['message'] = 'Successfully Without Name';
                        $status['status'] = 200;
                  } else {
                        $data['message'] = 'Failed Without Name';
                        $status['status'] = 404;
                  }
            } else if ($email == null || $email == "") {
                  $update['username_user'] = $username;
                  $update['name_role'] = $role;
                  $update['phone_user'] = $phone;
                  $query = $this->db->update('tb_user', $update);
                  if ($query) {
                        $data['message'] = 'Successfully Without Name';
                        $status['status'] = 200;
                  } else {
                        $data['message'] = 'Failed Without Name';
                        $status['status'] = 404;
                  }
            } else if ($phone == null || $phone == "") {
                  $update['username_user'] = $username;
                  $update['name_role'] = $role;
                  $update['email_user'] = $email;
                  $query = $this->db->update('tb_user', $update);
                  if ($query) {
                        $data['message'] = 'Successfully Without Name';
                        $status['status'] = 200;
                  } else {
                        $data['message'] = 'Failed Without Name';
                        $status['status'] = 404;
                  }
            } else {
                  $update['username_user'] = $username;
                  $update['name_role'] = $role;
                  $update['email_user'] = $email;
                  $update['phone_user'] = $phone;
                  $query = $this->db->update('tb_user', $update);
                  if ($query) {
                        $data['message'] = 'Successfully Without Name';
                        $status['status'] = 200;
                  } else {
                        $data['message'] = 'Failed Without Name';
                        $status['status'] = 404;
                  }
            }
            echo json_encode($data);
      }
}
