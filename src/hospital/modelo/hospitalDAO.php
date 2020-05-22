<?php

namespace conn;

class HospitalDao {

    //? Create
    public function create(Hospital $h) {
        try {
            $sql = 'INSERT INTO HOSPITAL (nomeHospital, ruaHospital, bairroHospital, cepHospital, telefoneHospital) 
                    VALUES (?, ?, ?, ?, ?)';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $h->getNomeHospital());
            $stmt->bindValue(2, $h->getRuaHospital());
            $stmt->bindValue(3, $h->getBairroHospital());
            $stmt->bindValue(4, $h->getCepHospital());
            $stmt->bindValue(5, $h->getTelefoneHospital());

            $stmt->execute();

            echo "true";
        } catch (\PDOException $e) {
            echo $e->getMessage();
        } 
    }

    //? Select
    public function list($requestData) {
        try {
            $columnData = $requestData['columns'];

            $sql = 'SELECT * FROM HOSPITAL';

            $stmt = Conexao::getConn()->prepare($sql);

            $stmt->execute();

            $registerCount = $stmt->rowCount();
   
            $columnOrder = $requestData['order'][0]['column']; 
            $order = $columnData[$columnOrder]['data']; 
            $direction = $requestData['order'][0]['dir'];

            $limitStart = $requestData['start'];
            $limitLenght = $requestData['length'];

            $totalFiltred = 0;

            $sql .= " ORDER BY $order $direction LIMIT $limitStart, $limitLenght ";

            if($registerCount > 0) {
                $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

                $json_data = array(
                    "draw" => intval($requestData['draw']),
                    "recordsTotal" => intval($registerCount),
                    "recordsFiltered" => intval($totalFiltred),
                    "data" => $result
                );

                echo json_encode($json_data);
        
            } else {
                echo [];
            }
        } catch (\PDOException $e) {
            echo $e->getCode();
        } 
    }

    //? Update
    public function update(Hospital $h, $array) {
        try {
            $sql = 'UPDATE HOSPITAL SET nomeHospital = ?, ruaHospital = ?, bairroHospital = ?, cepHospital = ?, telefoneHospital = ? WHERE id = ?';
            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue("1", $h->getNomeHospital());
            $stmt->bindValue("2", $h->getRuaHospital());
            $stmt->bindValue("3", $h->getBairroHospital());
            $stmt->bindValue("4", $h->getCepHospital());
            $stmt->bindValue("5", $h->getTelefoneHospital());

            $stmt->execute();
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }

    //? Delete
    public function delete($id) {
        try {
            $sql = 'DELETE FROM HOSPITAL WHERE idHospital = ?';
    
            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $id);
            
            $stmt->execute();     
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }
}