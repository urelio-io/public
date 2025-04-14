#!/bin/sh
aws iam create-user --user-name urelio_cspm && \
aws iam attach-user-policy --user-name urelio_cspm --policy-arn arn:aws:iam::aws:policy/SecurityAudit && \
echo '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":["ses:DescribeActiveReceiptRuleSet","athena:GetWorkGroup","logs:DescribeLogGroups","logs:DescribeMetricFilters","elastictranscoder:ListPipelines","elasticfilesystem:DescribeFileSystems","servicequotas:ListServiceQuotas"],"Resource":"*"}]}' > urelio-cspm-credentials.json && \
policy_arn=$(aws iam create-policy \
    --policy-name urelio_cspmSupplemental \
    --policy-document file://urelio_cspmSupplementalPolicy.json \
    --query 'Policy.Arn' --output text) && \
aws iam attach-user-policy --user-name urelio_cspm --policy-arn "$policy_arn" && \
aws iam create-access-key --user-name urelio_cspm > urelio-cspm-credentials.json && \
cat ~/urelio-cspm-credentials.json && \
rm ~/urelio-cspm-credentials.json
