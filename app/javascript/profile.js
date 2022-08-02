document.getElementById('profile_pic').addEventListener('click', clickAvatarForm); 
document.getElementById('avatar_file').addEventListener('change', submitAvatarForm);

function clickAvatarForm() {
  document.getElementById('avatar_file').click();
}

function submitAvatarForm() { 
  document.getElementById('avatar_upload_form').submit();
}