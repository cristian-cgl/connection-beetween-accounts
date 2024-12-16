echo "Comprimiendo lambda..."
rm -rf lambda.zip
cd lambda
zip -r ../lambda.zip *
cd ../
echo "Lambda comprimida."