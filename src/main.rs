#[tokio::main]
async fn main() -> Result<(), anyhow::Error> {
    ostt::run().await
}
