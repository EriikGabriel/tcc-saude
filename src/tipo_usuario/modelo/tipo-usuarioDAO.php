<?php

namespace conn;

class TipoUsuarioDao
{

    //? Create
    public function create(TipoUsuario $tu)
    {
        try {
            $sql = 'INSERT INTO TIPO_USUARIO (tipoUsuario) VALUES (?)';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $tu->getTipoUsuario());

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

            $sql = 'SELECT * FROM TIPO_USUARIO WHERE 1 = 1 ';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->execute();

            $registerCount = $stmt->rowCount();

            $filter = $requestData['search']['value'];

            if (!empty($filter)) {
                $sql .= " AND (idTipoUsuario LIKE '$filter%'
                          OR tipoUsuario LIKE '$filter%') ";
            }

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->execute();

            $totalFiltred = $stmt->rowCount();

            $columnOrder = $requestData['order'][0]['column'];
            $order = $columnData[$columnOrder]['data'];
            $direction = $requestData['order'][0]['dir'];

            $limitStart = $requestData['start'];
            $limitLenght = $requestData['length'];

            $sql .= " ORDER BY $order $direction LIMIT $limitStart, $limitLenght ";

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->execute();

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

    public function search($id)
    {
        try {
            $sql = 'SELECT * FROM TIPO_USUARIO WHERE idTipoUsuario = ?';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $id);
            $stmt->execute();

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
            $sql = "UPDATE TIPO_USUARIO SET tipoUsuario = ? WHERE idTipoUsuario = ?";

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $array[1]);
            $stmt->bindValue(2, $array[0]);

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
            $sql = 'DELETE FROM TIPO_USUARIO WHERE idTipoUsuario = ?';

            $stmt = Conexao::getConn()->prepare($sql);
            $stmt->bindValue(1, $id);

            $stmt->execute();

            echo "true";
        } catch (\PDOException $e) {
            echo $e->getCode();
        }
    }
}
