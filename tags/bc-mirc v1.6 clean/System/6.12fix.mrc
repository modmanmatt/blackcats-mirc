ctcp *:dcc send:*: if ($len($nopath($filename)) >= 225) { echo 4 -s $nick tried to crash you with an illegal dcc send of $nopath($filename) | halt }