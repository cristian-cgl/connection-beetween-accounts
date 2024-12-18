const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");

async function getItemById(tableName, id, Credentials = undefined) {
    const client = new DynamoDBClient({
        region: "us-east-1",
        credentials: Credentials ? ({
            accessKeyId: Credentials.AccessKeyId,
            secretAccessKey: Credentials.SecretAccessKey,
            sessionToken: Credentials.SessionToken
        }) : undefined
    });
    const command = new GetItemCommand({
        TableName: tableName,
        Key: {
            "id": { "S": id }
        }
    });
    const reply = await client.send(command);
    return reply.Item;
}

module.exports = {
    getItemById
}