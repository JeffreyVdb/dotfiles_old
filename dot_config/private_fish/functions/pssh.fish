function pssh --wraps='ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519_sk -l jeffreyvandenborne' --description 'alias pssh=ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519_sk -l jeffreyvandenborne'
  ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519_sk -l jeffreyvandenborne $argv; 
end
