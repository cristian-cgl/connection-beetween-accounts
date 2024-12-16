async function getAppVersion(tableName, credentials = undefined) {
    const client = new DynamoDBClient({
        region: "us-east-1",
        credentials
    });
    const command = new GetItemCommand({
        TableName: tableName,
        Key: {
            "id": { "S": "app-version" }
        }
    });
    const reply = await client.send(command);
    return reply.Item.version.S;
}

module.exports = {
    getAppVersion
}