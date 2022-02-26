function fish_user_key_bindings --wraps=fish_hybrid_key_bindings --description 'alias fish_user_key_bindings fish_hybrid_key_bindings'
  fish_hybrid_key_bindings $argv; 
end
