function pssh --wraps='ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519 -l jeffreyvandenborne' --description 'alias pssh=ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519 -l jeffreyvandenborne'
  ssh -oIdentitiesOnly=true -i ~/.ssh/id_ed25519 -l jeffreyvandenborne $argv; 
end
