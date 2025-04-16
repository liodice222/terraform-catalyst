# terraform-catalyst
Archive for terraform scripts
Objective: Notify admin that a restricted resource was made by event service rules 
	- TODO: Research tagging option - can you automatically tag resources that have already been made

	1. Setup Policies 
	allow group <group_name> to manage ons-topics in compartment <compartment_name>
	allow group <group_name> to manage ons-subscriptions in compartment <compartment_name>


	2. Create Notifications Topic & Subscription
	Developer Services --> App Integration --> Notifications 
		* Can only add one email per subscription so consider splitting Event Rules
		Under Topic add Subscription with admin email 

	3. Create Events Service Rule 
	Observability and Management --> Events Service --> Rules 
		
	
	

Data Flow- createapplication

Vmware Solution - createcluster.begin

OIC Create - createworkspace.begin 
createintegrationinstance.begin

Exadata - createcloudexadatainfrastrcture.begin

Other Resources to consider for Event Services:
	- GoldenGate
	goldengate.stateactive
	goldengate.createdatabaseregistration.begin
	goldengate.createdeployment.begin
	
	- Networking Services
	Create Internet Gateway 
	Instance pools
	
Resources not included in Oracle Event Services
	- BM Instances - functions
	- Scan for bm in logs 
	- Ipsec tunnels

Test Output - OIC Create
	admin as liodice
	
Pre-requisites to Creating OIC Instance and Workspace 
Policies: 
Allow group <group-name> to manage dis-workspaces in compartment LeaTesting
Allow group <group-name> to manage dis-work-requests in compartment LeaTesting
Allow group <group-name> to manage tag-namespaces in compartment LeaTesting
Allow group <group-name> to use virtual-network-family in compartment LeaTesting
Allow service dataintegration to use virtual-network-family in compartment LeaTesting
Allow group <group-name> to inspect instance-family in compartment LeaTesting

Create VCN with Public Subnet and Internet Connectivity 
	
Create OIC Instance 
Developer Services --> App Integration --> Integration 
Create Instance 
	- Instance details 
		○ Standard 
		○ BYOL 
		○ 1 message pack 

See Event Notification Output - Create OIC Instance AD3

Create OIC Workspace 
https://docs.oracle.com/en-us/iaas/data-integration/using/creating-a-workspace.htm


Next Steps

Implementation: 
Determine appropriate event types and notification topic and admins 
	- Configure Notification Topic, subscriptions to admin and Event rules
		○ Confirm which event services to include 
	- Consider utilizing OCI Functions for:

		
		
		
		
Resources:
https://docs.oracle.com/en/cloud/paas/autonomous-database/dedicated/adbar/index.html#articletitle
https://docs.oracle.com/en-us/iaas/Content/Notification/Concepts/notificationoverview.htm
https://docs.oracle.com/en-us/iaas/Content/Events/Concepts/eventsgetstarted.htm


