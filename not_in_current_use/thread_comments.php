<?php

    class Threaded_comments  
    {  
          
        public $parents  = array();  
        public $children = array();  
      
        /** 
         * @param array $comments  
         */  
        function __construct($comments)  
        {  
            foreach ($comments as $comment)  
            {  
                if ($comment['parent_id'] === NULL)  
                {  
                    $this->parents[$comment['id']][] = $comment;  
                }  
                else  
                {  
                    $this->children[$comment['parent_id']][] = $comment;  
                }  
            }          
        }  
         
        /** 
         * @param array $comment 
         * @param int $depth  
         */  
        private function format_comment($comment, $depth)  
        {     
            for ($depth; $depth > 0; $depth--)  
            {  
                echo "\t";  
            }  
              
            echo $comment['text'];  
            echo "\n";  
        }  
          
        /** 
         * @param array $comment 
         * @param int $depth  
         */   
        private function print_parent($comment, $depth = 0)  
        {     
            foreach ($comment as $c)  
            {  
                $this->format_comment($c, $depth);  
      
                if (isset($this->children[$c['id']]))  
                {  
                    $this->print_parent($this->children[$c['id']], $depth + 1);  
                }  
            }  
        }  
      
        public function print_comments()  
        {  
            foreach ($this->parents as $c)  
            {  
                $this->print_parent($c);  
            }  
        }  
        
    }
?>