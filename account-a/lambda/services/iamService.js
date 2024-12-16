async function getAssumeRoleCredentials(roleArn, roleSessionName) {
    const client = new STSClient({
        region: "us-east-1"
    });
    const response = await client.send(
        new AssumeRoleCommand({
            RoleArn: roleArn,
            RoleSessionName: roleSessionName
        })
    );
    return response.Credentials;
}

module.exports = {
    getAssumeRoleCredentials
}