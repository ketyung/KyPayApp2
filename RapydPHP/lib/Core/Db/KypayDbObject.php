<?php
namespace Core\Db;

use Db\DbObject as DbObject;

class KypayDbObject extends DbObject {


    public function findBy($pk){
        
        $result = parent::findBy($pk);
        
        if (count($result) > 0){
            
            $row = $result[0];
            $this->loadResultToProperties($row);
            return true ;
        }
        
        return false ;
    }
    
    
    public function insert(Array &$input){
        
        if (!isset($input['last_updated'])) {
        
            $input['last_updated'] = date('Y-m-d H:i:s');
        }
        
        return parent::insert($input);
    }

    public function update(Array $input, $toRecreateStatement = false)
    {
        
        if (!isset($input['last_updated'])) {
        
            $input['last_updated'] = date('Y-m-d H:i:s');
        }
        
        return parent::update ($input, $toRecreateStatement);
        
    }
    
}
?>
