package gplustest::DB::Result::User;

use Class::Method::Modifiers;

use DBIx::Class::Candy
    -autotable  => v1;

primary_column id   => {
    data_type           => 'text',
};

column email => {
    data_type           => 'text',
    is_nullable         => 0,
};

column sub => {
    data_type   => 'text',
    is_nullable => 0,
};

column password     => {
    data_type           => 'text',
    is_nullable         => 1,
};

column openid_id => {
    data_type => 'text',
};

unique_constraint([ qw/email sub/ ]);
1;
