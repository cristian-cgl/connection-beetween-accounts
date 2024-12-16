const { getAppVersion } = require("./services/dynamoService");
const { getAssumeRoleCredentials } = require("./services/iamService");

// index.js
exports.handler = async (event) => {
    console.log("Evento recibido:", event);

    // const credentials = await getAssumeRoleCredentials(
    //     process.env.LAMBDA_ROLE_ARN,
    //     process.env.LAMBDA_ROLE_SESSION_NAME
    // );

    const version = await getAppVersion(process.env.LAMBDA_TABLE_APP_SETTINGS);
    console.log("Version:", version);

    return {
        statusCode: 200,
        body: JSON.stringify({ message: "¡Hola desde Lambda! v" + version }),
    };
};