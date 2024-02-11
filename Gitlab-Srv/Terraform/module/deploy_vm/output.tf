output "vm_ip_addr" {
  value       = vsphere_virtual_machine.vm.default_ip_address
  description = "The private IP address of the vm instance."

  #depends_on = [ data.vsphere_network.network.id, ]
}

output "playbook_stderr" {
  value = ansible_playbook.playbook.ansible_playbook_stderr
}

output "playbook_stdout" {
    value = ansible_playbook.playbook.ansible_playbook_stdout
}