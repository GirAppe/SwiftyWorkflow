enum QRCodePayload {
    case upload(UploadPayload)
    case login(LoginPayload)
    case other(String)
}
