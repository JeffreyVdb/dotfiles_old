function cpusmart --wraps='sudo cpupower frequency-set -g schedutil' --description 'alias cpusmart=sudo cpupower frequency-set -g schedutil'
  sudo cpupower frequency-set -g schedutil $argv; 
end
