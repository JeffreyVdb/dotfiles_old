function apdc --wraps='ansible-playbook --diff --check' --description 'alias apdc=ansible-playbook --diff --check'
  ansible-playbook --diff --check $argv; 
end
