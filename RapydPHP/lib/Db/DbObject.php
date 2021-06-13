<?php
namespace Db;

use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;
use Util\StrUtil as StrUtil;
use Util\Log as Log;



class DbObject extends SQLBuilder {

	protected $insertStatement = null ;
	
	protected $updateStatement = null ;
	
	protected $deleteStatement = null ;
	
	protected $findAllStatement = null ; 
	
	protected $findByPKStatement = null ; 
	
	protected $findCountStatementt = null ; 
	
	protected $findByStatementt = null ;
    
    protected $lastErrorMessage = null ;
    
    const ERROR_ON_TX = -111;
    
	
	protected function prepareParams(Array $input){
		
		$a = array();
		
		$cols = $this->getColumnNames();
		$vals = $this->getColumnsDefaultValue();
		
		$c = count($cols);
		
		for($i = 0; $i < $c; $i++){
			
			$col = $cols[$i];
			$val = $vals[$i];
			$a[$col] = $input[$col] ?? $val;
				
		}
		
		
		return $a;
	}
	
    
    protected function prepareParamsForUpdate(Array $input){
        
        $a = array();
        
        $cols = $this->getColumnNames();
        
        $keys = array_keys($input);
        
        foreach($keys as $key){
            
            if (in_array($key, $cols)){
                
                $a[$key] = $input[$key];
            }
        }
        
        
        return $a;
    }
    
   
	
	public function insert(Array &$input){
		
		
		try {
        
			if (!isset($this->insertStatement)){
			
               // Log::printRToErrorLog($sql);
				$this->insertStatement = $this->db->prepare($this->buildInsertSql());
			}
		
        
			$this->insertStatement->execute($this->prepareParams($input));
            
            return $this->insertStatement->rowCount();
        }
        catch (\PDOException $e) {
        
            $this->lastErrorMessage = $e->getMessage();
            return self::ERROR_ON_TX;
        }    
		
	}
	
	
	public function update(Array $input, $toRecreateStatement = false ){
		
		
		try
        {
        
            if ($toRecreateStatement){
            
                $this->updateStatement = $this->db->prepare($this->buildUpdateSql($input));
        
            }
            else {
        
                if (!isset($this->updateStatement)){
                
                    $this->updateStatement = $this->db->prepare($this->buildUpdateSql($input));
                }
            
            }
            
            $params = $this->prepareParamsForUpdate($input);
          
			$this->updateStatement->execute($params);
            
            return $this->updateStatement->rowCount();
        }
        catch (\PDOException $e) {
        
            $this->lastErrorMessage = $e->getMessage();
            
            return self::ERROR_ON_TX;
        }
		
	}
	
	
	public function delete(Array $pk){
		
		try {
        
			if (!isset($this->deleteStatement)){
			
                $this->deleteStatement = $this->db->prepare($this->buildDeleteSql());
			}
		
        
			$this->deleteStatement->execute($this->prepareParams($pk));
            
            return $this->deleteStatement->rowCount();
        }
        catch (\PDOException $e) {
        
            $this->lastErrorMessage = $e->getMessage();
            return self::ERROR_ON_TX;
     
        }
	
		
	}
	
	
	public function findAll($start = null, $rows = null){
		
		
		try {
				
			if (!isset($this->findAllStatement)){
				
				$this->findAllStatement = $this->db->prepare($this->buildFindAllSql( $start, $rows ));
			}
		
			
            $this->findAllStatement->execute();
            
            
            $result = $this->findAllStatement->fetchAll(\PDO::FETCH_ASSOC);
            
            return $result;
        }
        catch (\PDOException $e) 
        {
            
            $this->lastErrorMessage = $e->getMessage();
            
            return null;
                
        }
		
	}
	
	
	public function findBy(Array $pk){
		
		
		try {
				
			if (!isset($this->findByPKStatement)){
				
				$this->findByPKStatement = $this->db->prepare($this->buildFindByPKSql());
			}
		
			
            $this->findByPKStatement->execute($pk);
            
            
            $result = $this->findByPKStatement->fetchAll(\PDO::FETCH_ASSOC);
            
            return $result;
        }
        catch (\PDOException $e) 
        {
            
            $this->lastErrorMessage = $e->getMessage();
            
            return null;
        }
		
	}
	
	
	public function findByWhere(ArrayOfSQLWhereCol $whereCols, $toRecreateStatement = false ){
		
		
		try {
				
            if ($toRecreateStatement){
                
                $this->findByStatement = $this->db->prepare($this->buildFindBySql($whereCols));
            }
            else {
            
                if (!isset($this->findByStatement)){
                    
                    $this->findByStatement = $this->db->prepare($this->buildFindBySql($whereCols));
                }
            
            }
            
			
		
			$cols = array();
			
			foreach ($whereCols as $wcol ){
				
				$cols[$wcol->name] = $wcol->value;
			}
		
			//print_r_to_elog($cols);
		
		
            $this->findByStatement->execute($cols);
            
            
            $result = $this->findByStatement->fetchAll(\PDO::FETCH_ASSOC);
            
            return $result;
        }
        catch (\PDOException $e) 
        {
            $this->lastErrorMessage = $e->getMessage();
            
            return null;
        }
		
	}
	
	
	
	public function count(Array $pk){
		
		
		try {
				
			if (!isset($this->findCountStatementt)){
				
				$this->findCountStatementt = $this->db->prepare($this->buildGetCountByPKSql());
			}
		
			
            $this->findCountStatementt->execute($pk);
            
            
            $result = $this->findCountStatementt->fetchAll(\PDO::FETCH_ASSOC);
            
            
            return $result[0]['count'] ?? 0; 
        }
        catch (\PDOException $e) 
        {
            
            $this->lastErrorMessage = $e->getMessage();
            return self::ERROR_ON_TX;
                
        }
		
	}
    
    
    public function getErrorMessage($toClear = true ){
        
        $e =  $this->lastErrorMessage;
        if ($toClear){
            
            $this->lastErrorMessage = null ;
        }
        
        return $e;
        
    }
	
	public function hasErrorMessage() {
        
        return isset($this->lastErrorMessage);
    }
    
    
    
    private function getTypeName(string $className, string $propertyName): ?string
    {
        $rp = new \ReflectionProperty($className, $propertyName);
        
        $ptype = $rp->getType();
        
        if (isset ($ptype)){
        
            //Log::printRToErrorLog($ptype);
            
            $n = $ptype->getName();
            
			$pos = strrpos($n, "\\");
                    
            $n = ($pos !== false) ? substr($n, $pos + 1 ) : $n ;
            
           // Log::printRToErrorLog($n);
                       
            return $n;
            
        }
        
        //Log::printRToErrorLog("null.type");
       
        return null;
    }
            

    protected function convertNumericIfAny(&$val){
        
        if ( is_numeric($val)) {
            
            if (is_double($val)){
                
                $val = doubleval($val);
                
                return;
                
            }
            else if (is_float($val)){
                
                $val = floatval($val);
                return;
            }
            else
            if (is_int($val)){
                
                $val = intval($val);
                return;
            }
            
            $val = doubleval($val);
            
        }
        
    }
            

    
    protected function loadResultToProperties($row){
        
        $cols = array_keys($row);
        
        $className = get_class($this);
        
        foreach($cols as $col){
            
            $propertyName = StrUtil::snakeToCamelCase ($col);
            
            if (property_exists($className, $propertyName)){
                
                //$code = '$rp = new \ReflectionProperty("'.$className.'","'. $propertyName.'");';
                
                $code  = '$val = $row[$col]; ';
                $code .= '$this->convertNumericIfAny($val);';
                
                //$code .= 'Log::printRToErrorLog("ptype:".$ptype);';
                $code .= '$this->'.$propertyName.' = $val;';
            
                
               // Log::printRToErrorLog($code);
                
                
                eval($code);
            }
            
        }
        
    }
	
    
    public function toJson(Array $excludes = null ){
        
        $public = [];
        $reflection = new \ReflectionClass($this);
        
        foreach ($reflection->getProperties(\ReflectionProperty::IS_PUBLIC) as $property) {
            
            if (isset($excludes)){
                
                if (!in_array($property->getName(), $excludes)){
              
                    $public[$property->getName()] = $property->getValue($this);
                }
              
            }
            else {
                
                $public[$property->getName()] = $property->getValue($this);
            }
            
        }
        return json_encode($public, JSON_NUMERIC_CHECK);
    }
    
    
    // a method to copy the object for with its public properties only
    public function copy(){
        
        $obj = null;
        
        $line = '$obj = new '.get_class($this).'(null,null);';
        
        //Log::printRToErrorLog($line);
        
        eval ($line);
        
        $reflection = new \ReflectionClass($this);
        foreach ($reflection->getProperties(\ReflectionProperty::IS_PUBLIC) as $property) {
        
            $line = '$obj->'.$property->getName().'=$this->'.$property->getName().';' ;
            
            //Log::printRToErrorLog($line);
            eval($line);
        }
        
        return $obj;
    }
    
	
}
?>
