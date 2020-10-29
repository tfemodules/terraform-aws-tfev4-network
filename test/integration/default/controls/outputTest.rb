control 'outputTest' do
    title 'Test Module Outputs'
    desc 'Confirms that the module outputs are as expected.'

    # test the subnets CIDRS to Id mappings
    [input('private_subnet_cidr_to_id'), input('public_subnet_cidr_to_id'), input('rds_subnet_cidr_to_id')].each do | mapping |
        mapping.each do | key, value |
            describe key do
                it { should match /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}/}
            end
            describe value do
                its('class') { should eq String }
                it { should match /^subnet-.*/ } 
            end
        end
    end

    # test the subnet ids output
    [input('private_subnet_ids'), input('public_subnet_ids'), input('rds_subnet_ids')].each do | subnetids |
        subnetids.each do | id |
            describe id do
                it { should match /^subnet-.*/ } 
            end
        end
    end

    # test the VPC output
    describe input('vpc_id') do 
       it { should match /^vpc-.*/ } 
    end

    # test NAT Gateway IP output
    describe input('nat_gateway_public_ip') do
        it { should match /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/}
    end
end