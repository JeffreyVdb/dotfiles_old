function apd --wraps='ansible-playbook --diff' --description 'alias apd=ansible-playbook --diff'
  ansible-playbook --diff $argv; 
end
