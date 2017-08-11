<?php
//if they set a url
if($_POST['url'])
{	
	echo $_POST['url'];
	echo '<br /><pre>';
	echo exec('./get.sh '.$_POST['url']);
	echo '</pre>';
}
//if they uploaded a file
$OTHERDIR="/var/www/localhost/htdocs/fdroid/repo/";
$valid_file = true;
if($_FILES['apk']['name'])
{
        //if no errors...
        if(!$_FILES['apk']['error'])
        {
                //now is the time to modify the future file name and validate the file
                $new_file_name = strtolower($_FILES['apk']['tmp_name']); //rename file
                if($_FILES['apk']['size'] > (10240000)) //can't be larger than 10 MB
                {
                        $valid_file = false;
                        $message = 'Oops!  Your file\'s size is to large.';
                }

                //if the file has passed the test
                if($valid_file)
                {
                        //move it to where we want it to be
                        $target = $OTHERDIR . basename($_FILES['apk']['name']);
                        move_uploaded_file($_FILES['apk']['tmp_name'], $target);
                        $message = 'Congratulations!  Your file was accepted.';
                }
        }
        //if there is an error...
        else
        {
                //set that to be the returned message
                $message = 'Ooops!  Your upload triggered the following error:  '.$_FILES['apk']['error'];
        }
	echo $message;
}

?>
