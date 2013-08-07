[Information]
Description=(Description): This module checks the IDs of the controls in a dialog for errors. $crlf (Location): When loaded, the module appears in the Control Editor's toolbar. $crlf (Version): 1.00 $crlf (Compatibility): Dialog Maker 0.10 or newer.
Author=KUKU BOI

[Module]
on *:signal:Modules_CE:did -a ce 1 +wa 3 $tab $chr(9) $+ Invalid ID Checker
on *:dialog:ce:sclick:1:if ($mid($did(1).seltext,$calc($pos($did(1).seltext,$gettok($did(1).seltext,3,32)) +1),$len($did(1).seltext)) == Invalid ID Checker) { IIDC }
alias -l IIDC {
  did -i DM 3 2 Checking for invalid IDs...
  set %i 1
  while (%i < $ini($var.read(Variables,dm.fn2),0)) {
    if ($readini($var.read(Variables,dm.fn2),%i,Control) !== $null) { set %str $addtok(%str,%i,44) }
    inc %i
  }
  set %i 1
  while (%i <= $numtok(%str,44)) {
    if ($gettok(%str,%i,44) < $calc($gettok(%str,$calc(%i +1),44) -1)) { echo -a Free ID - $calc($gettok(%str,%i,44) +1) }
    elseif ($gettok(%str,%i,44) > $gettok(%str,$calc(%i +1),44)) { echo -a Previous ID with larger value - $gettok(%str,%i,44) larger than $gettok(%str,$calc(%i +1),44) }
    elseif ($gettok(%str,%i,44) == $gettok(%str,$calc(%i +1),44)) { echo -a Same IDs - $gettok(%str,%i,44) equal to the next id }
    inc %i
  }
  unset %str
  unset %i
  did -i DM 3 2 Ready
}
