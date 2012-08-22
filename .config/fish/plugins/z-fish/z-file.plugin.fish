
if xsource ~/local/git/z-fish/z.fish
  function --on-event fish_prompt z-fish
    z --add "$PWD"
  end
end
