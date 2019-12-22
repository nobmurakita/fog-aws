Shindo.tests('AWS::ELBV2 | load_balancer_tests', ['aws', 'elb']) do
  @load_balancer_id = 'fog-test-elb'
  @key_name = 'fog-test'
  vpc = Fog::Compute[:aws].create_vpc('10.255.254.64/28').body['vpcSet'].first
  @subnet_id = Fog::Compute[:aws].create_subnet(vpc['vpcId'], vpc['cidrBlock']).body['subnet']['subnetId']

  tests('success') do
    tests("#create_load_balancer").formats(AWS::ELBV2::Formats::CREATE_LOAD_BALANCER) do
      options = {
        subnets: [@subnet_id]
      }
      Fog::AWS[:elbv2].create_load_balancer(@load_balancer_id, options).body
    end
  end
end
