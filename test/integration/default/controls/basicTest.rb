control 'basicTest' do
  title 'Basic Tests'
  desc 'Confirms that the VPC exists and that the subnets are part of it.'
  
  describe aws_vpc(vpc_id: input('vpc_id')) do
    it { should exist }
  end

  describe aws_subnets.where(vpc_id: input('vpc_id')) do
    its('subnet_ids') { should include input('public_subnet_ids')[0] }
    its('subnet_ids') { should include input('public_subnet_ids')[1] }
    its('subnet_ids') { should include input('private_subnet_ids')[0] }
    its('subnet_ids') { should include input('private_subnet_ids')[1] }
    its('subnet_ids') { should include input('rds_subnet_ids')[0] }
    its('subnet_ids') { should include input('rds_subnet_ids')[1] }
  end

end