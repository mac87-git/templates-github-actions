# Asumir otro rol utilizando STS
echo "Assuming the deployment role..."
export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
  $(aws sts assume-role \
    --role-arn "${INPUT_CICD_DEPLOYMENT_ROLE}" \
    --role-session-name gh-actions-call \
    --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
    --output text))

# Enmascarar las credenciales para evitar que se muestren en los logs
echo "::add-mask::$AWS_ACCESS_KEY_ID"
echo "::add-mask::$AWS_SECRET_ACCESS_KEY"
echo "::add-mask::$AWS_SESSION_TOKEN"

# Guardar las credenciales como variables de entorno
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> $GITHUB_ENV
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> $GITHUB_ENV
echo "AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> $GITHUB_ENV