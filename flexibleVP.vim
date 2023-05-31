if exists('g:loaded_flexibleVP') || &cp
  finish
endif
let g:loaded_flexibleVP = 1

command! -nargs=1 Launch call flexibleVP#Launch(<q-args>)
command! -nargs=+ Addw call flexibleVP#Addw(<q-args>)
command! -nargs=+ Adda call flexibleVP#Adda(<q-args>)

function! flexibleVP#Launch(app)
  let web_addresses_file = expand('~/vimfiles/plugged/flexibleVP/data/webaddress.txt')
  let app_addresses_file = expand('~/vimfiles/plugged/flexibleVP/data/appaddress.txt')

  let web_addresses = readfile(web_addresses_file)
  let app_addresses = readfile(app_addresses_file)

  let address = ''
  let is_web_address = 0

  " Check if the given app is a web address
  for line in web_addresses
    if line =~ '^' . a:app . ':'
      let address = substitute(line, '^' . a:app . ':\s*', '', '')
      let is_web_address = 1
      break
    endif
  endfor

  if empty(address)
    for line in app_addresses
      if line =~ '^' . a:app . ':'
        let address = substitute(line, '^' . a:app . ':\s*', '', '')
        break
      endif
    endfor
  endif

  if empty(address)
    echo 'Address for ' . a:app . ' not found.'
  else
    if is_web_address
      if has('win32') || has('win64')
        let cmd = 'start "" ' . shellescape(address, 1)
        call system(cmd)
      elseif has('macunix')
        let cmd = 'open ' . shellescape(address, 1)
        call system(cmd)
      else
        let cmd = 'xdg-open ' . shellescape(address, 1)
        call system(cmd)
      endif
    else
      if has('win32') || has('win64')
        let cmd = 'start "" ' . shellescape(address, 1)
        call system(cmd)
      else
        let cmd = 'xdg-open ' . shellescape(address, 1)
        call system(cmd)
      endif
    endif
  endif
endfunction

function! flexibleVP#Addw(name, address)
endfunction

function! flexibleVP#Adda(name, address)
endfunction
