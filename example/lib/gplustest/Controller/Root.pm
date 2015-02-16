package gplustest::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

gplustest::Controller::Root - Root Controller for gplustest

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->serve_static_file('root/static/login.html');

}

sub login :Path(/login) :Args(0) {
    my ($self, $c) = @_;

    my $email = $c->request->params->{email};
    my $id_token = $c->request->params->{id_token};

    if ($c->model('DB::User')->find({
        email => $email,
    })) {
        if ( $c->authenticate ({ email => $email, id_token => $id_token }) ) {
            $c->response->body('logged in!');
        } else {
            $c->response->body('not logged in!');
        }
    } else {
        use Catalyst::Plugin::Authentication::Credential::GooglePlus;

        use LWP::Simple;
        use JSON::MaybeXS;

        my $data = Catalyst::Plugin::Authentication::Credential::GooglePlus->decode(
            $id_token,
            decode_json(get('https://www.googleapis.com/oauth2/v1/certs'))
        );

        my $sub = $data->{sub};
        my $openid_id = $data->{openid_id};

        $c->model("DB::User")->create({
                id          => $sub,
                sub         => $sub,
                openid_id   => $openid_id,
                email       => $email,
            });

        $c->response->body('signed up!');
    }
}

=head2 default

Standard 404 error page

=cut

    sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Errietta Kostala,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
