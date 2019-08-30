<?php
require_once 'api/listid.php';

$ids = uupListIds();
if(isset($ids['error'])) {
    throwError($ids['error']);
}
