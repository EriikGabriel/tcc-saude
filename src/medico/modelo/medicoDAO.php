<?php

namespace conn;

class MedicoDao
{

    //? Create
    public function create(Medico $m)
    {
        try {
            $sql = 'INSERT INTO MEDICO (CRM, nomeMedico, horarioMedico, idEspecialidade) 
                    VALUES (?, ?, ?, ?)';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $m->getCrm());
            $stmt->bindValue(2, $m->getNomeMedico());
            $stmt->bindValue(3, $m->getHorarioMedico());
            $stmt->bindValue(4, $m->getIdEspecialidade());

            $stmt->execute();

            echo "true";
        } catch (\PDOException $e) {
            echo $e->getMessage();
        }
    }

    //? Select
    public function list($requestData)
    {
        try {
            $columnData = $requestData['columns'];

            $sql = 'SELECT `MEDICO`.`CRM`, `MEDICO`.`nomeMedico`, DATE_FORMAT(`MEDICO`.`horarioMedico`, "%H:%i") AS horarioMedico, `ESPECIALIDADE`.`tipoEspecialidade`
            FROM MEDICO
            INNER JOIN ESPECIALIDADE ON (`MEDICO`.`idEspecialidade` = `ESPECIALIDADE`.`idEspecialidade`)';

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

            $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

            $json_data = array(
                "draw" => intval($requestData['draw']),
                "recordsTotal" => intval($registerCount),
                "recordsFiltered" => intval($totalFiltred),
                "data" => $result
            );

            echo json_encode($json_data);
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }

    public function search($id, $table, $isWhere, $where = null)
    {
        try {
            if ($isWhere == true) {
                $sql = "SELECT * FROM {$table} WHERE {$where} = ?";

                $stmt = Conexao::getConn()->prepare($sql);
                $stmt->bindValue(1, $id);
                $stmt->execute();
            } else {
                $sql = "SELECT * FROM {$table}";

                $stmt = Conexao::getConn()->prepare($sql);
                $stmt->execute();
            }

            if ($stmt->rowCount() > 0) {
                $result = $stmt->fetchAll(\PDO::FETCH_ASSOC);

                echo json_encode($result);
            }
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }

    //? Update
    public function edit($array)
    {
        try {
            $sql = "UPDATE MEDICO SET CRM = ?, nomeMedico = ?, horarioMedico = ?, idEspecialidade = ? WHERE CRM = ?";

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $array[1]);
            $stmt->bindValue(2, $array[2]);
            $stmt->bindValue(3, $array[3]);
            $stmt->bindValue(4, $array[4]);
            $stmt->bindValue(5, $array[0]);

            $stmt->execute();

            echo "true";
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }

    //? Delete
    public function delete($id)
    {
        try {
            $sql = 'DELETE FROM MEDICO WHERE CRM = ?';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $id);

            $stmt->execute();

            echo "true";
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }
}