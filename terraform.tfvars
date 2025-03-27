# rule_condition example

rule_condition = <<EOT
{
        "eventType": [
        "com.oraclecloud.dataflow.createapplication",
        "com.oraclecloud.vmwaresolution.createcluster.begin",
        "com.oraclecloud.integration.createintegrationinstance.begin",
        "com.oraclecloud.dataintegration.createworkspace.begin",
        "com.oraclecloud.databaseservice.createcloudexadatainfrastructure.begin",
        "com.oraclecloud.goldengate.createdeployment.begin",
        "com.oraclecloud.computemanagement.createinstancepool.begin",
        "com.oraclecloud.virtualnetwork.createinternetgateway"
] }
EOT
