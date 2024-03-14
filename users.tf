
# Get the user data from GCP for me (the currently authenticated user).
data "google_client_openid_userinfo" "me" {
}

# Add the local ssh public to my GCP user. 
# This is a convenient way to deploy my SSH public key to each of the VM's I deploy.
resource "google_os_login_ssh_public_key" "default" {
  user = data.google_client_openid_userinfo.me.email
  key  = file(var.local_ssh_public_key)
}