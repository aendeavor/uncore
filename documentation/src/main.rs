use rocket_contrib::serve::StaticFiles;
use rocket::config::{
	Config,
	Environment,
	LoggingLevel,
};

fn main()
{
	let application = rocket::custom(
		Config::build(Environment::Production)
			.address("0.0.0.0")
			.port(8080)
			.log_level(LoggingLevel::Critical)
			.secret_key("AfMs5/uaxAeYoNQSnJlbOgp2Z1vyDC0N8AHTxIdQL+U=")
			.finalize()
			.expect("Configuration resulted in an error. Aborting.")
	);

	application.mount("/", StaticFiles::from("/site")).launch();
}
