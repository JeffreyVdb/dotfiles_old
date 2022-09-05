function avno --wraps='aws-vault exec --no-session jeffrey -- fish' --description 'alias avno=aws-vault exec --no-session jeffrey -- fish'
  aws-vault exec --no-session jeffrey -- fish $argv; 
end
