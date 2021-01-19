# Citrix ADC Module

used to create vips on the netscaler device

## Dependencies

### local exec
this module uses `local-exec` for that reason some binaries are required on the system. this was used in favor of writing a custom provider in order to make miantence easier as well as leverage the TKGI cli for api compatibility. this is only used for the ns commit script which is outlined [here](https://github.com/citrix/terraform-provider-citrixadc#running)

* curl


### citrix provider
this module also uses the the [citrix provider](https://github.com/citrix/terraform-provider-citrixadc). they are working on getting this added to the main hashi registry but for the time being it needs to be added localy as a plugin. this can be added to the `~/.terraform.d/plugins/` directory with the following path.

`terraform.example.com/citrix/citrixadc/<version>/<arch>/terraform-provider-citrixadc`

the reference to this is in the `main.tf` file , this is formatting is new with terraform 0.13