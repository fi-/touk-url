module Handler.EncodeSpec (spec) where

import Handler.Encode
import TestImport
import Text.Parsec

parseURL :: Text -> Either ParseError ()
parseURL = parse parser "url"

goodUrls :: [Text]
goodUrls = "http://valid.pl"
         : "http://lol-valid.pl"
         : "http://bal.pl:1337"
         : "https://touk.pl/?token=as2df"
         : "http://192.168.1.10/home/"
         : "http://192.10.10.10:12/home"
         : "http://touk.pl/admin/admin/admin/?pw=tajne"
         : []

badUrls :: [Text]
badUrls = "htt://badurl.pl"
        : "http://.touk.jp/"
        : "touk.pl"
        : "127.0.0.1:274"
        : "http://you.are.bad.pl:/"
        : []


spec :: Spec
spec = testsWithApp >> testsWithoutApp

testsWithApp :: Spec
testsWithApp = withApp $ do
  it "POSTing URL should return 2 shortened urls" $ do
    request $ do
      setUrl EncodeR
      setMethod "POST"
      addToken
      byLabel "url" "http://touk.pl"

    statusIs 200
    htmlCount ".classyEncoded" 1
    htmlCount ".funnyEncoded" 1

testsWithoutApp :: Spec
testsWithoutApp = do
  describe "Handler.Encode parser valid urls" $ do
    forM_ goodUrls $ \url ->
      it (unpack url) $ parseURL url `shouldBe` Right ()

  describe "Handler.Encode parser invalid urls" $ do
    forM_ badUrls $ \url ->
      it (unpack url) $ parseURL url `shouldNotBe` Right ()


