on 1:dialog:Away:init:0:{ Load.Away.Settings }
on 1:dialog:away:edit:3:{ 
  if ($did(away,3) == $null) { CSet away nick NotSet }
  else { CSet away nick $did(away,3) }
}
on 1:dialog:away:edit:31:{ 
  if ($did(away,31) == $null) { CSet away icq NotSet }
  else { CSet away icq $did(away,31) }
}
on 1:dialog:away:edit:33:{ 
  if ($did(away,33) == $null) { CSet away email NotSet }
  else { CSet away email $did(away,33) }
}
on 1:dialog:away:edit:7:{ CSet away ind $calc($did(away,7) * 60) }
on 1:dialog:away:edit:10:{ CSet away sd $calc($did(away,10) * 60) }
on 1:dialog:away:sclick:12:{ dialog -m pager pager } 
on 1:dialog:away:sclick:4:{ 
  if ($did(away,4).state == 1) { CSet away pager on } 
  else { CSet away pager off } 
}
on 1:dialog:away:sclick:66:{ 
  if ($did(away,66).state == 1) { CSet away -o+v on } 
  else { CSet away -o+v off } 
}
on 1:dialog:away:edit:37:{ 
  if ($did(away,37) != $null) { CSet away delay $calc($did(away,37) * 60) } 
  else { CSet away delay 900 } 
}
on 1:dialog:away:sclick:6:{ 
  if ($did(away,6).state == 1) { 
    cset away inactive on
    did -v away 7
    did -v away 8
    did -r away 7 
    did -a away 7 $calc($sets(away,ind) / 60)
  } 
  else {
    did -h away 7 
    did -h away 8 
    cset away inactive off
  }
}
on 1:dialog:away:sclick:9:{ 
  if ($did(away,9).state == 1) { 
    cset away start on
    did -v away 10
    did -v away 11
    did -r away 10 
    did -a away 10 $calc($sets(away,sd) / 60)
  } 
  else {
    did -h away 10 
    did -h away 11 
    cset away start off
  }
}